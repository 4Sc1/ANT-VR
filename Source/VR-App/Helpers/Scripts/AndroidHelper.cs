using System;
using UnityEngine;

namespace Assets.Helpers.Scripts
{
    public class AndroidHelper
    {
        static AndroidJavaObject androidInfo;
        static AndroidJavaClass versionInfo;

        static AndroidHelper()
        {
            androidInfo = new AndroidJavaObject("android.os.Build");
            versionInfo = new AndroidJavaClass("android.os.Build$VERSION");
        }

        public static string GetDeviceId()
        {
            try
            {
                return androidInfo.GetStatic<string>("SERIAL");
            }
            catch (Exception ex)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(ex);
            }

            return string.Empty;
        }

        public static string BASE_OS
        {
            get
            {
                return versionInfo.GetStatic<string>("BASE_OS");
            }
        }

        public static string CODENAME
        {
            get
            {
                return versionInfo.GetStatic<string>("CODENAME");
            }
        }

        public static string INCREMENTAL
        {
            get
            {
                return versionInfo.GetStatic<string>("INCREMENTAL");
            }
        }

        public static int PREVIEW_SDK_INT
        {
            get
            {
                return versionInfo.GetStatic<int>("PREVIEW_SDK_INT");
            }
        }

        public static string RELEASE
        {
            get
            {
                return versionInfo.GetStatic<string>("RELEASE");
            }
        }

        public static string SDK
        {
            get
            {
                return versionInfo.GetStatic<string>("SDK");
            }
        }

        public static int SDK_INT
        {
            get
            {
                return versionInfo.GetStatic<int>("SDK_INT");
            }
        }

        public static string SECURITY_PATCH
        {
            get
            {
                return versionInfo.GetStatic<string>("SECURITY_PATCH");
            }
        }

        public static string ALL_VERSION
        {
            get
            {
                string version = "BASE_OS: " + BASE_OS + ", ";
                version += "CODENAME: " + CODENAME + ", ";
                version += "INCREMENTAL: " + INCREMENTAL + ", ";
                version += "PREVIEW_SDK_INT: " + PREVIEW_SDK_INT + ", ";
                version += "RELEASE: " + RELEASE + ", ";
                version += "SDK: " + SDK + ", ";
                version += "SDK_INT: " + SDK_INT + ", ";
                version += "SECURITY_PATCH: " + SECURITY_PATCH;

                return version;
            }
        }
    }
}
