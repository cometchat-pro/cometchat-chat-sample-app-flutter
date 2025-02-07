package com.cometchat.cometchat_uikit_shared

import android.Manifest
import android.Manifest.permission.READ_EXTERNAL_STORAGE
import android.Manifest.permission.RECORD_AUDIO
import android.Manifest.permission.WRITE_EXTERNAL_STORAGE
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.media.MediaPlayer
import android.media.MediaRecorder
import android.os.Build
import android.os.Environment
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import java.io.IOException
import java.util.Date
import java.text.SimpleDateFormat

/**
 * AudioRecorder class
 *
 * This class is used to record and play recorded audio
 *
 * @param context the Context of component from where the instance of AudioRecorder is created.
 * @property audioRecorder the object that contains the audioRecorder.
 * @constructor Creates an MediaRecorder object.
 */
class AudioRecorder (private val context: Context, private val activity: Activity) {


    // creating a variable for media recorder object class.
    var audioRecorder: MediaRecorder? = null

    // creating a variable for media-player class
    private var audioPlayer: MediaPlayer? = null

    // string variable is created for storing a file name
    private var fileName: String? = null

//    private var timer: Timer? = null

    // constant for storing audio permission
    public fun startRecording(): Boolean {
        // check permission method is used to check
        // that the user has granted permission
        // to record and store the audio.
        if (checkPermissions()) {
            // we are here initializing our filename variable
            // with the path of the recorded audio file.
            fileName = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)?.absolutePath

            fileName += "/audio-recording-${SimpleDateFormat("yyyyMMddHHmmss").format(Date())}.m4a"
            Log.e("AudioRecorder","permission granted for audio recording $fileName")

            // below method is used to initialize
            // the media recorder class
            audioRecorder = MediaRecorder()

            // below method is used to set the audio
            // source which we are using a mic.
            audioRecorder?.setAudioSource(MediaRecorder.AudioSource.MIC)

            // below method is used to set
            // the output format of the audio.
            audioRecorder?.setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)

            // below method is used to set the
            // audio encoder for our recorded audio.
            audioRecorder?.setAudioEncoder(MediaRecorder.AudioEncoder.AAC)

            // below method is used to set the
            // output file location for our recorded audio
                audioRecorder?.setOutputFile(fileName)
                Log.e("AudioRecorder","lower version permission granted for audio recording $fileName")

            try {
                // below method will prepare
                // our audio recorder class
                audioRecorder?.prepare()
            } catch (e: IOException) {
                Log.e("TAG", "prepare() failed")
            }
            // start method will start
            // the audio recording.
            audioRecorder?.start()
            return true
        } else {
//             if audio recording permissions are
//             not granted by user below method will
//             ask for runtime permission for mic and storage.

            requestPermissions()
            Log.e("AudioRecorder","permission not granted for audio recording or write to external storage so request permission")
            return false
        }
    }


    private fun requestPermissions() {
        // this method is used to request
        // the permission for audio recording and storage.
        if (ContextCompat.checkSelfPermission(context, RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
        Log.e("AudioRecorder","in requestPermissions permission not granted for audio recording so request permission")
            ActivityCompat.requestPermissions(activity,  arrayOf<String>(RECORD_AUDIO), 101);
        }

    }

    private  fun checkPermissions(): Boolean {
        // this method is used to check permission
        val audioRecordAccess = ContextCompat.checkSelfPermission(context, RECORD_AUDIO)
        return   audioRecordAccess == PackageManager.PERMISSION_GRANTED
    }


    fun playAudio() {

        // for playing our recorded audio
        // we are using media player class.
        audioPlayer = MediaPlayer()
        try {
            // below method is used to set the
            // data source which will be our file name
            audioPlayer?.setDataSource(fileName)

            // below method will prepare our media player
            audioPlayer?.prepare()

            // below method will start our media player.
            audioPlayer?.start()
        } catch (e: IOException) {
            Log.e("TAG", "prepare() failed")
        }
    }

    public fun stopRecording():String? {

        // below method will stop
        // the audio recording.
        audioRecorder?.stop()


        // below method will release
        // the media recorder class.
        audioRecorder?.release()
        audioRecorder = null
        return fileName
    }

    fun pausePlaying() {
        audioPlayer?.pause()
    }

    ///[stopPlaying] stops the audio player
    private fun stopPlaying(){
        audioPlayer?.stop()
        audioPlayer?.release()
        audioPlayer = null
    }

    /// release all media resources
    fun releaseMediaResources(){
        if (audioRecorder!=null ){
            stopRecording()
        }
        if (audioPlayer!=null || audioPlayer?.isPlaying == true){
            stopPlaying()
        }
    }

    public fun pauseRecording(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N &&  audioRecorder!=null) {
            audioRecorder?.pause()
        }
    }

    public fun resumeRecording():Boolean{
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N &&  audioRecorder!=null) {
            audioRecorder?.resume()
            return true
        }else{
            return false
        }
    }
}
