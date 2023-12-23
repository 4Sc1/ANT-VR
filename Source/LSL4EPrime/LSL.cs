using System;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

///Remark: This file contains source code from the liblsl .NET repository.
///Copyright: 2018 Christian Kothe
///License: MIT License

///Permission is hereby granted, free of charge, to any person obtaining a copy
///of this software and associated documentation files (the "Software"), to deal
///in the Software without restriction, including without limitation the rights
///to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
///copies of the Software, and to permit persons to whom the Software is
///furnished to do so, subject to the following conditions:
///
///The above copyright notice and this permission notice shall be included in all
///copies or substantial portions of the Software.
///
///THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
///IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
///FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
///LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
///SOFTWARE.
namespace LSL
{
  internal class liblsl
  {
    public const double IRREGULAR_RATE = 0.0;
    public const double DEDUCED_TIMESTAMP = -1.0;
    public const double FOREVER = 32000000.0;

    public static int protocol_version() => liblsl.dll.lsl_protocol_version();

    public static int library_version() => liblsl.dll.lsl_library_version();

    public static double local_clock() => liblsl.dll.lsl_local_clock();

    public static liblsl.StreamInfo[] resolve_streams(double wait_time = 1.0)
    {
      IntPtr[] buffer = new IntPtr[1024];
      int length = liblsl.dll.lsl_resolve_all(buffer, (uint) buffer.Length, wait_time);
      liblsl.StreamInfo[] streamInfoArray = new liblsl.StreamInfo[length];
      for (int index = 0; index < length; ++index)
        streamInfoArray[index] = new liblsl.StreamInfo(buffer[index]);
      return streamInfoArray;
    }

    public static liblsl.StreamInfo[] resolve_stream(
      string prop,
      string value,
      int minimum = 1,
      double timeout = 32000000.0)
    {
      IntPtr[] buffer = new IntPtr[1024];
      int length = liblsl.dll.lsl_resolve_byprop(buffer, (uint) buffer.Length, prop, value, minimum, timeout);
      liblsl.StreamInfo[] streamInfoArray = new liblsl.StreamInfo[length];
      for (int index = 0; index < length; ++index)
        streamInfoArray[index] = new liblsl.StreamInfo(buffer[index]);
      return streamInfoArray;
    }

    public static liblsl.StreamInfo[] resolve_stream(string pred, int minimum = 1, double timeout = 32000000.0)
    {
      IntPtr[] buffer = new IntPtr[1024];
      int length = liblsl.dll.lsl_resolve_bypred(buffer, (uint) buffer.Length, pred, minimum, timeout);
      liblsl.StreamInfo[] streamInfoArray = new liblsl.StreamInfo[length];
      for (int index = 0; index < length; ++index)
        streamInfoArray[index] = new liblsl.StreamInfo(buffer[index]);
      return streamInfoArray;
    }

    public static void check_error(int ec)
    {
      if (ec >= 0)
        return;
      switch (ec)
      {
        case -4:
          throw new liblsl.InternalException("An internal internal error has occurred.");
        case -3:
          throw new ArgumentException("An argument was incorrectly specified (e.g., wrong format or wrong length).");
        case -2:
          throw new liblsl.LostException("The stream has been lost.");
        case -1:
          throw new TimeoutException("The operation failed due to a timeout.");
        default:
          throw new Exception("An unknown error has occurred.");
      }
    }

    public enum channel_format_t : byte
    {
      cf_undefined,
      cf_float32,
      cf_double64,
      cf_string,
      cf_int32,
      cf_int16,
      cf_int8,
      cf_int64,
    }

    public enum processing_options_t : byte
    {
      proc_none = 0,
      proc_clocksync = 1,
      proc_dejitter = 2,
      proc_monotonize = 4,
      proc_threadsafe = 8,
      proc_ALL = 15, // 0x0F
    }

    public class StreamInfo
    {
      private IntPtr obj;

      public StreamInfo(
        string name,
        string type,
        int channel_count = 1,
        double nominal_srate = 0.0,
        liblsl.channel_format_t channel_format = liblsl.channel_format_t.cf_float32,
        string source_id = "")
      {
        this.obj = liblsl.dll.lsl_create_streaminfo(name, type, channel_count, nominal_srate, channel_format, source_id);
      }

      public StreamInfo(IntPtr handle) => this.obj = handle;

      ~StreamInfo() => liblsl.dll.lsl_destroy_streaminfo(this.obj);

      public string name() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_get_name(this.obj));

      public string type() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_get_type(this.obj));

      public int channel_count() => liblsl.dll.lsl_get_channel_count(this.obj);

      public double nominal_srate() => liblsl.dll.lsl_get_nominal_srate(this.obj);

      public liblsl.channel_format_t channel_format()
      {
        return liblsl.dll.lsl_get_channel_format(this.obj);
      }

      public string source_id() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_get_source_id(this.obj));

      public int version() => liblsl.dll.lsl_get_version(this.obj);

      public double created_at() => liblsl.dll.lsl_get_created_at(this.obj);

      public string uid() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_get_uid(this.obj));

      public string session_id()
      {
        return Marshal.PtrToStringAnsi(liblsl.dll.lsl_get_session_id(this.obj));
      }

      public string hostname() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_get_hostname(this.obj));

      public liblsl.XMLElement desc() => new liblsl.XMLElement(liblsl.dll.lsl_get_desc(this.obj));

      public string as_xml()
      {
        IntPtr xml = liblsl.dll.lsl_get_xml(this.obj);
        string stringAnsi = Marshal.PtrToStringAnsi(xml);
        liblsl.dll.lsl_destroy_string(xml);
        return stringAnsi;
      }

      public IntPtr handle() => this.obj;
    }

    public class StreamOutlet
    {
      private IntPtr obj;

      public StreamOutlet(liblsl.StreamInfo info, int chunk_size = 0, int max_buffered = 360)
      {
        this.obj = liblsl.dll.lsl_create_outlet(info.handle(), chunk_size, max_buffered);
      }

      ~StreamOutlet() => liblsl.dll.lsl_destroy_outlet(this.obj);

      public void push_sample(float[] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_sample_ftp(this.obj, data, timestamp, pushthrough ? 1 : 0);
      }

      public void push_sample(double[] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_sample_dtp(this.obj, data, timestamp, pushthrough ? 1 : 0);
      }

      public void push_sample(int[] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_sample_itp(this.obj, data, timestamp, pushthrough ? 1 : 0);
      }

      public void push_sample(short[] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_sample_stp(this.obj, data, timestamp, pushthrough ? 1 : 0);
      }

      public void push_sample(char[] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_sample_ctp(this.obj, data, timestamp, pushthrough ? 1 : 0);
      }

      public void push_sample(string[] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_sample_strtp(this.obj, data, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(float[,] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_ftp(this.obj, data, (uint) data.Length, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(double[,] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_dtp(this.obj, data, (uint) data.Length, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(int[,] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_itp(this.obj, data, (uint) data.Length, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(short[,] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_stp(this.obj, data, (uint) data.Length, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(char[,] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_ctp(this.obj, data, (uint) data.Length, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(string[,] data, double timestamp = 0.0, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_strtp(this.obj, data, (uint) data.Length, timestamp, pushthrough ? 1 : 0);
      }

      public void push_chunk(float[,] data, double[] timestamps, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_ftnp(this.obj, data, (uint) data.Length, timestamps, pushthrough ? 1 : 0);
      }

      public void push_chunk(double[,] data, double[] timestamps, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_dtnp(this.obj, data, (uint) data.Length, timestamps, pushthrough ? 1 : 0);
      }

      public void push_chunk(int[,] data, double[] timestamps, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_itnp(this.obj, data, (uint) data.Length, timestamps, pushthrough ? 1 : 0);
      }

      public void push_chunk(short[,] data, double[] timestamps, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_stnp(this.obj, data, (uint) data.Length, timestamps, pushthrough ? 1 : 0);
      }

      public void push_chunk(char[,] data, double[] timestamps, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_ctnp(this.obj, data, (uint) data.Length, timestamps, pushthrough ? 1 : 0);
      }

      public void push_chunk(string[,] data, double[] timestamps, bool pushthrough = true)
      {
        liblsl.dll.lsl_push_chunk_strtnp(this.obj, data, (uint) data.Length, timestamps, pushthrough ? 1 : 0);
      }

      public bool have_consumers() => liblsl.dll.lsl_have_consumers(this.obj) > 0;

      public bool wait_for_consumers(double timeout = 32000000.0)
      {
        return liblsl.dll.lsl_wait_for_consumers(this.obj) > 0;
      }

      public liblsl.StreamInfo info() => new liblsl.StreamInfo(liblsl.dll.lsl_get_info(this.obj));
    }

    public class StreamInlet
    {
      private IntPtr obj;

      public StreamInlet(
        liblsl.StreamInfo info,
        int max_buflen = 360,
        int max_chunklen = 0,
        bool recover = true,
        liblsl.processing_options_t postproc_flags = liblsl.processing_options_t.proc_none)
      {
        this.obj = liblsl.dll.lsl_create_inlet(info.handle(), max_buflen, max_chunklen, recover ? 1 : 0);
        liblsl.dll.lsl_set_postprocessing(this.obj, postproc_flags);
      }

      ~StreamInlet() => liblsl.dll.lsl_destroy_inlet(this.obj);

      public liblsl.StreamInfo info(double timeout = 32000000.0)
      {
        int ec = 0;
        IntPtr fullinfo = liblsl.dll.lsl_get_fullinfo(this.obj, timeout, ref ec);
        liblsl.check_error(ec);
        return new liblsl.StreamInfo(fullinfo);
      }

      public void open_stream(double timeout = 32000000.0)
      {
        int ec = 0;
        liblsl.dll.lsl_open_stream(this.obj, timeout, ref ec);
        liblsl.check_error(ec);
      }

      public void close_stream() => liblsl.dll.lsl_close_stream(this.obj);

      public double time_correction(double timeout = 32000000.0)
      {
        int ec = 0;
        double num = liblsl.dll.lsl_time_correction(this.obj, timeout, ref ec);
        liblsl.check_error(ec);
        return num;
      }

      public double pull_sample(float[] sample, double timeout = 32000000.0)
      {
        int ec = 0;
        double num = liblsl.dll.lsl_pull_sample_f(this.obj, sample, sample.Length, timeout, ref ec);
        liblsl.check_error(ec);
        return num;
      }

      public double pull_sample(double[] sample, double timeout = 32000000.0)
      {
        int ec = 0;
        double num = liblsl.dll.lsl_pull_sample_d(this.obj, sample, sample.Length, timeout, ref ec);
        liblsl.check_error(ec);
        return num;
      }

      public double pull_sample(int[] sample, double timeout = 32000000.0)
      {
        int ec = 0;
        double num = liblsl.dll.lsl_pull_sample_i(this.obj, sample, sample.Length, timeout, ref ec);
        liblsl.check_error(ec);
        return num;
      }

      public double pull_sample(short[] sample, double timeout = 32000000.0)
      {
        int ec = 0;
        double num = liblsl.dll.lsl_pull_sample_s(this.obj, sample, sample.Length, timeout, ref ec);
        liblsl.check_error(ec);
        return num;
      }

      public double pull_sample(char[] sample, double timeout = 32000000.0)
      {
        int ec = 0;
        double num = liblsl.dll.lsl_pull_sample_c(this.obj, sample, sample.Length, timeout, ref ec);
        liblsl.check_error(ec);
        return num;
      }

      public double pull_sample(string[] sample, double timeout = 32000000.0)
      {
        int ec = 0;
        IntPtr[] buffer = new IntPtr[sample.Length];
        double num = liblsl.dll.lsl_pull_sample_str(this.obj, buffer, buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        try
        {
          for (int index = 0; index < buffer.Length; ++index)
            sample[index] = Marshal.PtrToStringAnsi(buffer[index]);
        }
        finally
        {
          for (int index = 0; index < buffer.Length; ++index)
            liblsl.dll.lsl_destroy_string(buffer[index]);
        }
        return num;
      }

      public int pull_chunk(float[,] data_buffer, double[] timestamp_buffer, double timeout = 0.0)
      {
        int ec = 0;
        int num = (int) liblsl.dll.lsl_pull_chunk_f(this.obj, data_buffer, timestamp_buffer, (uint) data_buffer.Length, (uint) timestamp_buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        int length = data_buffer.GetLength(1);
        return num / length;
      }

      public int pull_chunk(double[,] data_buffer, double[] timestamp_buffer, double timeout = 0.0)
      {
        int ec = 0;
        int num = (int) liblsl.dll.lsl_pull_chunk_d(this.obj, data_buffer, timestamp_buffer, (uint) data_buffer.Length, (uint) timestamp_buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        int length = data_buffer.GetLength(1);
        return num / length;
      }

      public int pull_chunk(int[,] data_buffer, double[] timestamp_buffer, double timeout = 0.0)
      {
        int ec = 0;
        int num = (int) liblsl.dll.lsl_pull_chunk_i(this.obj, data_buffer, timestamp_buffer, (uint) data_buffer.Length, (uint) timestamp_buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        int length = data_buffer.GetLength(1);
        return num / length;
      }

      public int pull_chunk(short[,] data_buffer, double[] timestamp_buffer, double timeout = 0.0)
      {
        int ec = 0;
        int num = (int) liblsl.dll.lsl_pull_chunk_s(this.obj, data_buffer, timestamp_buffer, (uint) data_buffer.Length, (uint) timestamp_buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        int length = data_buffer.GetLength(1);
        return num / length;
      }

      public int pull_chunk(char[,] data_buffer, double[] timestamp_buffer, double timeout = 0.0)
      {
        int ec = 0;
        int num = (int) liblsl.dll.lsl_pull_chunk_c(this.obj, data_buffer, timestamp_buffer, (uint) data_buffer.Length, (uint) timestamp_buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        int length = data_buffer.GetLength(1);
        return num / length;
      }

      public int pull_chunk(string[,] data_buffer, double[] timestamp_buffer, double timeout = 0.0)
      {
        int ec = 0;
        IntPtr[,] data_buffer1 = new IntPtr[data_buffer.GetLength(0), data_buffer.GetLength(1)];
        uint num = liblsl.dll.lsl_pull_chunk_str(this.obj, data_buffer1, timestamp_buffer, (uint) data_buffer1.Length, (uint) timestamp_buffer.Length, timeout, ref ec);
        liblsl.check_error(ec);
        try
        {
          for (int index1 = 0; index1 < data_buffer1.GetLength(0); ++index1)
          {
            for (int index2 = 0; index2 < data_buffer1.GetLength(1); ++index2)
              data_buffer[index1, index2] = Marshal.PtrToStringAnsi(data_buffer1[index1, index2]);
          }
        }
        finally
        {
          for (int index3 = 0; index3 < data_buffer1.GetLength(0); ++index3)
          {
            for (int index4 = 0; index4 < data_buffer1.GetLength(1); ++index4)
              liblsl.dll.lsl_destroy_string(data_buffer1[index3, index4]);
          }
        }
        return (int) num / data_buffer.GetLength(1);
      }

      public int samples_available() => (int) liblsl.dll.lsl_samples_available(this.obj);

      public bool was_clock_reset() => liblsl.dll.lsl_was_clock_reset(this.obj) > 0U;
    }

    public struct XMLElement
    {
      private IntPtr obj;

      public XMLElement(IntPtr handle) => this.obj = handle;

      public liblsl.XMLElement first_child()
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_first_child(this.obj));
      }

      public liblsl.XMLElement last_child()
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_last_child(this.obj));
      }

      public liblsl.XMLElement next_sibling()
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_next_sibling(this.obj));
      }

      public liblsl.XMLElement previous_sibling()
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_previous_sibling(this.obj));
      }

      public liblsl.XMLElement parent() => new liblsl.XMLElement(liblsl.dll.lsl_parent(this.obj));

      public liblsl.XMLElement child(string name)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_child(this.obj, name));
      }

      public liblsl.XMLElement next_sibling(string name)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_next_sibling_n(this.obj, name));
      }

      public liblsl.XMLElement previous_sibling(string name)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_previous_sibling_n(this.obj, name));
      }

      public bool empty() => liblsl.dll.lsl_empty(this.obj) != 0;

      public bool is_text() => liblsl.dll.lsl_is_text(this.obj) != 0;

      public string name() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_name(this.obj));

      public string value() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_value(this.obj));

      public string child_value() => Marshal.PtrToStringAnsi(liblsl.dll.lsl_child_value(this.obj));

      public string child_value(string name)
      {
        return Marshal.PtrToStringAnsi(liblsl.dll.lsl_child_value_n(this.obj, name));
      }

      public liblsl.XMLElement append_child_value(string name, string value)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_append_child_value(this.obj, name, value));
      }

      public liblsl.XMLElement prepend_child_value(string name, string value)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_prepend_child_value(this.obj, name, value));
      }

      public bool set_child_value(string name, string value)
      {
        return liblsl.dll.lsl_set_child_value(this.obj, name, value) != 0;
      }

      public bool set_name(string rhs) => liblsl.dll.lsl_set_name(this.obj, rhs) != 0;

      public bool set_value(string rhs) => liblsl.dll.lsl_set_value(this.obj, rhs) != 0;

      public liblsl.XMLElement append_child(string name)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_append_child(this.obj, name));
      }

      public liblsl.XMLElement prepend_child(string name)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_prepend_child(this.obj, name));
      }

      public liblsl.XMLElement append_copy(liblsl.XMLElement e)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_append_copy(this.obj, e.obj));
      }

      public liblsl.XMLElement prepend_copy(liblsl.XMLElement e)
      {
        return new liblsl.XMLElement(liblsl.dll.lsl_prepend_copy(this.obj, e.obj));
      }

      public void remove_child(string name) => liblsl.dll.lsl_remove_child_n(this.obj, name);

      public void remove_child(liblsl.XMLElement e) => liblsl.dll.lsl_remove_child(this.obj, e.obj);
    }

    public class ContinuousResolver
    {
      private IntPtr obj;

      public ContinuousResolver() => this.obj = liblsl.dll.lsl_create_continuous_resolver(5.0);

      public ContinuousResolver(double forget_after)
      {
        this.obj = liblsl.dll.lsl_create_continuous_resolver(forget_after);
      }

      public ContinuousResolver(string prop, string value)
      {
        this.obj = liblsl.dll.lsl_create_continuous_resolver_byprop(prop, value, 5.0);
      }

      public ContinuousResolver(string prop, string value, double forget_after)
      {
        this.obj = liblsl.dll.lsl_create_continuous_resolver_byprop(prop, value, forget_after);
      }

      public ContinuousResolver(string pred)
      {
        this.obj = liblsl.dll.lsl_create_continuous_resolver_bypred(pred, 5.0);
      }

      public ContinuousResolver(string pred, double forget_after)
      {
        this.obj = liblsl.dll.lsl_create_continuous_resolver_bypred(pred, forget_after);
      }

      ~ContinuousResolver() => liblsl.dll.lsl_destroy_continuous_resolver(this.obj);

      public liblsl.StreamInfo[] results()
      {
        IntPtr[] buffer = new IntPtr[1024];
        int length = liblsl.dll.lsl_resolver_results(this.obj, buffer, (uint) buffer.Length);
        liblsl.StreamInfo[] streamInfoArray = new liblsl.StreamInfo[length];
        for (int index = 0; index < length; ++index)
          streamInfoArray[index] = new liblsl.StreamInfo(buffer[index]);
        return streamInfoArray;
      }
    }

    public class LostException : Exception
    {
      public LostException()
      {
      }

      public LostException(string message)
      {
      }

      public LostException(string message, Exception inner)
      {
      }

      protected LostException(SerializationInfo info, StreamingContext context)
      {
      }
    }

    public class InternalException : Exception
    {
      public InternalException()
      {
      }

      public InternalException(string message)
      {
      }

      public InternalException(string message, Exception inner)
      {
      }

      protected InternalException(SerializationInfo info, StreamingContext context)
      {
      }
    }

    private class dll
    {
      private const string libname = "lsl";

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_protocol_version();

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_library_version();

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_local_clock();

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_create_streaminfo(
        string name,
        string type,
        int channel_count,
        double nominal_srate,
        liblsl.channel_format_t channel_format,
        string source_id);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_destroy_streaminfo(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_name(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_type(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_get_channel_count(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_get_nominal_srate(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern liblsl.channel_format_t lsl_get_channel_format(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_source_id(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_get_version(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_get_created_at(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_uid(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_session_id(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_hostname(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_desc(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_xml(IntPtr info);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_create_outlet(IntPtr info, int chunk_size, int max_buffered);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_destroy_outlet(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_ftp(
        IntPtr obj,
        float[] data,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_dtp(
        IntPtr obj,
        double[] data,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_itp(
        IntPtr obj,
        int[] data,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_stp(
        IntPtr obj,
        short[] data,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_ctp(
        IntPtr obj,
        char[] data,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_strtp(
        IntPtr obj,
        string[] data,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_sample_buftp(
        IntPtr obj,
        char[][] data,
        uint[] lengths,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_ftp(
        IntPtr obj,
        float[,] data,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_ftnp(
        IntPtr obj,
        float[,] data,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_dtp(
        IntPtr obj,
        double[,] data,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_dtnp(
        IntPtr obj,
        double[,] data,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_itp(
        IntPtr obj,
        int[,] data,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_itnp(
        IntPtr obj,
        int[,] data,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_stp(
        IntPtr obj,
        short[,] data,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_stnp(
        IntPtr obj,
        short[,] data,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_ctp(
        IntPtr obj,
        char[,] data,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_ctnp(
        IntPtr obj,
        char[,] data,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_strtp(
        IntPtr obj,
        string[,] data,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_strtnp(
        IntPtr obj,
        string[,] data,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_buftp(
        IntPtr obj,
        char[][] data,
        uint[] lengths,
        uint data_elements,
        double timestamp,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_push_chunk_buftnp(
        IntPtr obj,
        char[][] data,
        uint[] lengths,
        uint data_elements,
        double[] timestamps,
        int pushthrough);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_have_consumers(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_wait_for_consumers(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_info(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_resolve_all(
        IntPtr[] buffer,
        uint buffer_elements,
        double wait_time);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_resolve_byprop(
        IntPtr[] buffer,
        uint buffer_elements,
        string prop,
        string value,
        int minimum,
        double wait_time);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_resolve_bypred(
        IntPtr[] buffer,
        uint buffer_elements,
        string pred,
        int minimum,
        double wait_time);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_create_inlet(
        IntPtr info,
        int max_buflen,
        int max_chunklen,
        int recover);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_destroy_inlet(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_get_fullinfo(IntPtr obj, double timeout, ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_open_stream(IntPtr obj, double timeout, ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_close_stream(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_time_correction(IntPtr obj, double timeout, ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_set_postprocessing(IntPtr obj, liblsl.processing_options_t flags);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_f(
        IntPtr obj,
        float[] buffer,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_d(
        IntPtr obj,
        double[] buffer,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_i(
        IntPtr obj,
        int[] buffer,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_s(
        IntPtr obj,
        short[] buffer,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_c(
        IntPtr obj,
        char[] buffer,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_str(
        IntPtr obj,
        IntPtr[] buffer,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern double lsl_pull_sample_buf(
        IntPtr obj,
        char[][] buffer,
        uint[] buffer_lengths,
        int buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_destroy_string(IntPtr str);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_f(
        IntPtr obj,
        float[,] data_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_d(
        IntPtr obj,
        double[,] data_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_i(
        IntPtr obj,
        int[,] data_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_s(
        IntPtr obj,
        short[,] data_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_c(
        IntPtr obj,
        char[,] data_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_str(
        IntPtr obj,
        IntPtr[,] data_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_pull_chunk_buf(
        IntPtr obj,
        char[][,] data_buffer,
        uint[,] lengths_buffer,
        double[] timestamp_buffer,
        uint data_buffer_elements,
        uint timestamp_buffer_elements,
        double timeout,
        ref int ec);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_samples_available(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern uint lsl_was_clock_reset(IntPtr obj);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_first_child(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_last_child(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_next_sibling(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_previous_sibling(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_parent(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_child(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_next_sibling_n(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_previous_sibling_n(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_empty(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_is_text(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_name(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_value(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_child_value(IntPtr e);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_child_value_n(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_append_child_value(IntPtr e, string name, string value);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_prepend_child_value(IntPtr e, string name, string value);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_set_child_value(IntPtr e, string name, string value);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_set_name(IntPtr e, string rhs);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_set_value(IntPtr e, string rhs);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_append_child(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_prepend_child(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_append_copy(IntPtr e, IntPtr e2);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_prepend_copy(IntPtr e, IntPtr e2);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_remove_child_n(IntPtr e, string name);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_remove_child(IntPtr e, IntPtr e2);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_create_continuous_resolver(double forget_after);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_create_continuous_resolver_byprop(
        string prop,
        string value,
        double forget_after);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern IntPtr lsl_create_continuous_resolver_bypred(
        string pred,
        double forget_after);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern int lsl_resolver_results(
        IntPtr obj,
        IntPtr[] buffer,
        uint buffer_elements);

      [DllImport("lsl", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.Cdecl)]
      public static extern void lsl_destroy_continuous_resolver(IntPtr obj);
    }
  }
}
