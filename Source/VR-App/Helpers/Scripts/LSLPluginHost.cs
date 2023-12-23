using System;
using UnityEngine;

namespace Assets.Helpers.Scripts
{
    public class LSLPluginHost : MonoBehaviour
    {
        private string _deviceId;
        private LSL.liblsl.StreamInfo _eventStreamInfo;
        private LSL.liblsl.StreamOutlet _eventStreamOutlet;

        private LSL.liblsl.StreamInfo _dataStreamInfo;
        private LSL.liblsl.StreamOutlet _dataStreamOutlet;

        private string _experimentName;

        void Start()
        {
            try
            {
                if (Debug.isDebugBuild)
                    Debug.Log(@"LSL version: " + LSL.liblsl.library_version() + @".");

                _deviceId = AndroidHelper.GetDeviceId();

                if (Debug.isDebugBuild)
                    Debug.Log(@"Device Id: " + _deviceId + @".");

                _experimentName = Application.productName + "_" + DateTimeOffset.Now.ToString("yyyy-MM-dd-HH-mm-ss");

                _eventStreamInfo = new LSL.liblsl.StreamInfo(_experimentName + @"_Events", @"Markers", 1, 0, LSL.liblsl.channel_format_t.cf_string, _deviceId);
                _eventStreamInfo.desc().append_child_value(@"manufacturer", Application.companyName);
                _eventStreamInfo.desc().append_child_value(@"app", Application.productName);
                _eventStreamInfo.desc().append_child_value(@"version", Application.version);
                _eventStreamInfo.desc().append_child_value(@"device ID", _deviceId);
                _eventStreamInfo.desc().append_child_value(@"os version", AndroidHelper.ALL_VERSION);
                _eventStreamOutlet = new LSL.liblsl.StreamOutlet(_eventStreamInfo);

                _dataStreamInfo = new LSL.liblsl.StreamInfo(_experimentName + @"_Data", @"Gyro", 3, 90, LSL.liblsl.channel_format_t.cf_float32, _deviceId);
                var channels = _dataStreamInfo.desc().append_child(@"channels");

                var gyroXChannel = channels.append_child(@"channel");
                gyroXChannel.append_child_value(@"label", @"X gyro (ANT-VR)");
                gyroXChannel.append_child_value(@"unit", @"°");
                gyroXChannel.append_child_value(@"type", @"Gyro");

                var gyroYChannel = channels.append_child(@"channel");
                gyroYChannel.append_child_value(@"label", @"Y gyro (ANT-VR)");
                gyroYChannel.append_child_value(@"unit", @"°");
                gyroYChannel.append_child_value(@"type", @"Gyro");

                var gyroZChannel = channels.append_child(@"channel");
                gyroZChannel.append_child_value(@"label", @"Z gyro (ANT-VR)");
                gyroZChannel.append_child_value(@"unit", @"°");
                gyroZChannel.append_child_value(@"type", @"Gyro");

                _dataStreamInfo.desc().append_child_value(@"manufacturer", Application.companyName);
                _dataStreamInfo.desc().append_child_value(@"app", Application.productName);
                _dataStreamInfo.desc().append_child_value(@"version", Application.version);
                _dataStreamInfo.desc().append_child_value(@"device ID", _deviceId);
                _dataStreamInfo.desc().append_child_value(@"os version", AndroidHelper.ALL_VERSION);
                _dataStreamOutlet = new LSL.liblsl.StreamOutlet(_dataStreamInfo);
            }
            catch (Exception ex)
            {
                Debug.LogError(ex.Message);
            }
        }

        public void PushEventMessage(int eventCode, double timeStamp)
        {
            if (!_eventStreamOutlet.have_consumers())
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(LSLPluginHost) + @"." + nameof(PushEventMessage) + @" Aborted. " + nameof(_eventStreamOutlet.have_consumers) + @" is null.");
                return;
            }

            try
            {
                _eventStreamOutlet.push_sample(new string[] { eventCode.ToString() }, timeStamp);
            }
            catch (Exception ex)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(LSLPluginHost) + @"." + nameof(PushEventMessage) + @" Exception: " + ex.Message);
            }
        }

        public void PushDataMessage(float gyroX, float gyroY, float gyroZ, double timeStamp)
        {
            if (!_dataStreamOutlet.have_consumers())
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(LSLPluginHost) + @"." + nameof(PushDataMessage) + @" Aborted. " + nameof(_dataStreamOutlet.have_consumers) + @" is null.");
                return;
            }

            try
            {
                _dataStreamOutlet.push_sample(new float[] { gyroX, gyroY, gyroZ }, timeStamp);
            }
            catch (Exception ex)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(LSLPluginHost) + @"." + nameof(PushDataMessage) + @" Exception: " + ex.Message);
            }
        }

        public string GetExperimentName()
        {
            if (!string.IsNullOrWhiteSpace(_experimentName))
                return _experimentName;

            return @"UNKNOWN";
        }

        public static double GetTimeStamp()
        {
            try
            {
                return LSL.liblsl.local_clock();
            }
            catch (System.Exception ex)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(LSLPluginHost) + @"." + nameof(GetTimeStamp) + @" Exception: " + ex.Message);
            }

            return Double.NaN;
        }
    }
}
