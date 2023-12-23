using System;
using System.Security.Cryptography;

namespace Assets.Helpers.Scripts
{
    /// <summary>
    /// Random number generator
    /// </summary>
    public class RandomNumbersGenerator : IDisposable
    {
        private RandomNumberGenerator _rng;
        private bool _disposed;

        public RandomNumbersGenerator()
        {
            _rng = RandomNumberGenerator.Create();
        }

		/// Source: Stack Overflow
		/// Author: John Leidegren
		/// Year: 2015
		/// Link: https://stackoverflow.com/questions/403572/how-to-get-random-double-value-out-of-random-byte-array-values
		/// License: https://creativecommons.org/licenses/by-sa/2.5/
		/// Remark: Original code has been changed.
        private double GetRandomMultiplier()
        {
            var bytes = new byte[8];
            _rng.GetBytes(bytes);
            var v = BitConverter.ToUInt64(bytes, 0);
            // We only use the 53-bits of integer precision available in a IEEE 754 64-bit double.
            // The result is a fraction,
            // r = (0, 9007199254740991) / 9007199254740992 where 0 <= r && r < 1.
            v &= ((1UL << 53) - 1);
            var r = (double)v / (double)(1UL << 53);
            return r;
        }

        public uint GetRandomUInt(uint minValue, uint maxValue)
        {
            if (minValue == maxValue)
                return maxValue;

            if (minValue > maxValue)
                throw new ArgumentException(nameof(minValue));

            var diff = maxValue - minValue;
            var result = Convert.ToUInt32(minValue + diff * GetRandomMultiplier());

            if (result > maxValue)
                return maxValue;

            return result;
        }

        public void Dispose()
        {
            Dispose(true);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (_disposed)
                return;

            if (disposing)
            {
                if (_rng != null)
                    _rng.Dispose();
            }

            _disposed = true;
        }
    }
}