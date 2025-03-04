import React, { useEffect, useRef } from 'react';
import videojs from 'video.js';
import 'video.js/dist/video-js.css';

const HlsPlayer = ({ source }) => {
  const videoRef = useRef(null);
  const playerRef = useRef(null); // Added playerRef to store Video.js player instance

  useEffect(() => {
    if (videoRef.current && !playerRef.current) {
      // Only initialize Video.js if videoRef is available and no player is already initialized
      playerRef.current = videojs(videoRef.current, {
        autoplay: true,
        controls: true,
        responsive: true,
        fluid: true,
        sources: [
          {
            src: source,
            type: 'application/x-mpegURL',
          },
        ],
      });
    }

    return () => {
      // Cleanup Video.js player on component unmount
      if (playerRef.current) {
        playerRef.current.dispose();
        playerRef.current = null;
      }
    };
  }, [source]); // Run effect only when 'source' changes

  return (
    <div>
      <video
        ref={videoRef} // Bind the ref to the video element
        className="video-js vjs-default-skin"
        controls
        preload="auto"
        width="640"
        height="360"
        muted // Helps with autoplay policies
      />
    </div>
  );
};

export default HlsPlayer;
