package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/elastic/go-elasticsearch/v7"
)

// Product represents the structure of a document stored in Elasticsearch
type Product struct {
	Name        string  `json:"name"`
	Description string  `json:"description"`
	Price       float64 `json:"price"`
}

var esClient *elasticsearch.Client
var elasticIndex string

// Initialize Elasticsearch client
func initElasticSearch() {
	esHost := os.Getenv("ELASTIC_HOST")
	esPort := os.Getenv("ELASTIC_PORT")
	elasticIndex = os.Getenv("ELASTIC_INDEX") // Elasticsearch index

	if esHost == "" || esPort == "" || elasticIndex == "" {
		log.Fatal("Elasticsearch environment variables (ELASTIC_HOST, ELASTIC_PORT, ELASTIC_INDEX) must be set.")
	}

	esURL := fmt.Sprintf("http://%s:%s", esHost, esPort)
	cfg := elasticsearch.Config{
		Addresses: []string{
			esURL, // Use the environment variable values
		},
		// Optional: Add authentication or other configurations if needed
	}
	client, err := elasticsearch.NewClient(cfg)
	if err != nil {
		log.Fatalf("Error creating the Elasticsearch client: %s", err)
	}
	esClient = client
	fmt.Println("Elasticsearch client initialized.")
}

// Fetch products from Elasticsearch based on the search query
func searchProducts(query string) ([]Product, error) {
	var products []Product

	// Build the search query
	searchQuery := map[string]interface{}{
		"query": map[string]interface{}{
			"match": map[string]interface{}{
				"name": query, // Match the query with product name
			},
		},
	}

	// Serialize query to JSON
	var buf strings.Builder
	if err := json.NewEncoder(&buf).Encode(searchQuery); err != nil {
		return nil, fmt.Errorf("Error encoding search query: %v", err)
	}

	// Convert the buffer to a string reader
	reader := strings.NewReader(buf.String())

	// Perform search request to Elasticsearch
	res, err := esClient.Search(
		esClient.Search.WithContext(context.Background()),
		esClient.Search.WithIndex(elasticIndex), // Use index from environment variable
		esClient.Search.WithBody(reader),        // Use the reader here
		esClient.Search.WithTrackTotalHits(true),
		esClient.Search.WithPretty(),
	)
	if err != nil {
		return nil, fmt.Errorf("Error executing search query: %v", err)
	}
	defer res.Body.Close()

	// Parse the Elasticsearch response
	var r map[string]interface{}
	if err := json.NewDecoder(res.Body).Decode(&r); err != nil {
		return nil, fmt.Errorf("Error parsing search response: %v", err)
	}

	// Extract the hits from the response
	hits := r["hits"].(map[string]interface{})["hits"].([]interface{})
	for _, hit := range hits {
		// Extract source and map it to Product struct
		source := hit.(map[string]interface{})["_source"]
		product := Product{
			Name:        source.(map[string]interface{})["name"].(string),
			Description: source.(map[string]interface{})["description"].(string),
			Price:       source.(map[string]interface{})["price"].(float64),
		}
		products = append(products, product)
	}

	return products, nil
}

// HTTP handler for search
func searchHandler(w http.ResponseWriter, r *http.Request) {
	query := r.URL.Query().Get("q") // Get the 'q' parameter from the URL query string
	if query == "" {
		http.Error(w, "Query parameter 'q' is missing", http.StatusBadRequest)
		return
	}

	// Search for products
	products, err := searchProducts(query)
	if err != nil {
		http.Error(w, fmt.Sprintf("Error searching products: %v", err), http.StatusInternalServerError)
		return
	}

	// Serialize the products to JSON and send as the response
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(products); err != nil {
		http.Error(w, "Error encoding response to JSON", http.StatusInternalServerError)
	}
}

func main() {
	// Initialize the Elasticsearch client
	initElasticSearch()

	// Start a simple web server
	http.HandleFunc("/search", searchHandler)
	port := ":8080"
	srv := &http.Server{
		Addr:         port,
		Handler:      nil,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	log.Printf("Starting server on port %s...\n", port)
	log.Fatal(srv.ListenAndServe())
}
