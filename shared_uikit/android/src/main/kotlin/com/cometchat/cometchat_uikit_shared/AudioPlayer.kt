package com.cometchat.cometchat_uikit_shared

import android.content.Context
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.os.Build

class AudioPlayer {
    private var isManuallyStopped = false // Track manual stop

    companion object {
        @Volatile
        private var mMediaPlayer: MediaPlayer? = null

        fun getMediaPlayer(): MediaPlayer {
            return mMediaPlayer ?: synchronized(this) {
                mMediaPlayer ?: MediaPlayer().also { mMediaPlayer = it }
            }
        }

        fun releaseMediaPlayer() {
            mMediaPlayer?.let {
                if (it.isPlaying) {
                    it.stop()
                }
                it.reset()
                it.release()
                mMediaPlayer = null
                Log.d("AudioPlayer", "Singleton MediaPlayer instance released")
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun playCustomSound(call: MethodCall, result: MethodChannel.Result, context: Context) {
        val assetAudioPath: String = call.argument("assetAudioPath") ?: ""

        try {
            Log.d("AudioPlayer", "Playing custom sound: $assetAudioPath")

            // Stop any existing playback before starting a new one
            val mediaPlayer = getMediaPlayer()
            if (mediaPlayer.isPlaying) {
                releaseMediaPlayer()
            }

            val afd = context.assets.openFd("flutter_assets/$assetAudioPath")
            mediaPlayer.setDataSource(afd.fileDescriptor, afd.startOffset, afd.declaredLength)
            afd.close()

            mediaPlayer.setAudioAttributes(
                AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build()
            )

            mediaPlayer.setOnPreparedListener {
                Log.d("AudioPlayer", "MediaPlayer prepared, starting playback")
                mediaPlayer.start()
            }

            mediaPlayer.setOnCompletionListener {
                Log.d("AudioPlayer", "Playback completed")
                if (!isManuallyStopped) {
                    releaseMediaPlayer()
                }
            }

            mediaPlayer.prepare()
            result.success("Sound Played")
        } catch (e: Exception) {
            Log.e("AudioPlayer", "Error playing custom sound: ${e.message}")
            result.error("ERROR", "Failed to play sound: ${e.message}", null)
        }
    }

    fun stopPlayer(result: MethodChannel.Result) {
        try {
            Log.d("AudioPlayer", "stopPlayer method called")

            isManuallyStopped = true
            // Stop any existing playback before starting a new one
            val mPlayer = getMediaPlayer()
            if (mPlayer.isPlaying) {
                releaseMediaPlayer()
            } else {
                Log.d("AudioPlayer", "MediaPlayer is already null or not playing")
            }

//            // Stop the current player if it's playing
//            if (mPlayer.isPlaying) {
//                releaseMediaPlayer()
//            }

            result.success("Player Stopped")
        } catch (e: Exception) {
            Log.e("AudioPlayer", "Error stopping player: ${e.message}")
            result.error("ERROR", "Failed to stop player: ${e.message}", null)
        }
    }
}