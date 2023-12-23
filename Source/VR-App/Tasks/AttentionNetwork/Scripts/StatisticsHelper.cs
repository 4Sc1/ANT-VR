using System;
using System.Collections.Generic;
using System.Linq;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
	/// Remark: This code is an altered copy of code from the Math.NET respository. It is under license of Math.NET.
	/// Copyright: 2009-2021 Math.NET
	/// License: Permission is hereby granted, free of charge, to any person
	/// obtaining a copy of this software and associated documentation
	/// files (the "Software"), to deal in the Software without
	/// restriction, including without limitation the rights to use,
	/// copy, modify, merge, publish, distribute, sublicense, and/or sell
	/// copies of the Software, and to permit persons to whom the
	/// Software is furnished to do so, subject to the following
	/// conditions:
	///
	/// The above copyright notice and this permission notice shall be
	/// included in all copies or substantial portions of the Software.
	///
	/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	/// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	/// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	/// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	/// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	/// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	/// OTHER DEALINGS IN THE SOFTWARE.
    internal static class StatisticsHelper
    {
        /// <summary>
        /// Computes the Spearman Ranked Correlation coefficient.
        /// </summary>
        /// <param name="dataA">Sample data series A.</param>
        /// <param name="dataB">Sample data series B.</param>
        /// <returns>The Spearman ranked correlation coefficient.</returns>
        internal static double Spearman(IEnumerable<double> dataA, IEnumerable<double> dataB)
        {
            try
            {
                return Pearson(Rank(dataA), Rank(dataB));
            }
            catch
            { 
            }

            return double.NaN;
        }

        internal static double[] GetRankableValues(uint[] values)
        {
            var rankableValues = new List<double>();

            try
            {
                foreach (var value in values)
                    rankableValues.Add(value);
            }
            catch
            {

            }

            return rankableValues.ToArray();
        }

        static double[] Rank(IEnumerable<double> series)
        {
            if (series == null)
            {
                return Array.Empty<double>();
            }

            // WARNING: do not try to cast series to an array and use it directly,
            // as we need to sort it (inplace operation)

            var data = series.ToArray();
            return RanksInplace(data);
        }

        /// <summary>
        /// Computes the Pearson Product-Moment Correlation coefficient.
        /// </summary>
        /// <param name="dataA">Sample data A.</param>
        /// <param name="dataB">Sample data B.</param>
        /// <returns>The Pearson product-moment correlation coefficient.</returns>
        static double Pearson(IEnumerable<double> dataA, IEnumerable<double> dataB)
        {
            int n = 0;
            double r = 0.0;

            double meanA = 0;
            double meanB = 0;
            double varA = 0;
            double varB = 0;

            // WARNING: do not try to "optimize" by summing up products instead of using differences.
            // It would indeed be faster, but numerically much less robust if large mean + low variance.

            using (IEnumerator<double> ieA = dataA.GetEnumerator())
            using (IEnumerator<double> ieB = dataB.GetEnumerator())
            {
                while (ieA.MoveNext())
                {
                    if (!ieB.MoveNext())
                    {
                        throw new ArgumentOutOfRangeException(nameof(dataB), "The array arguments must have the same length.");
                    }

                    double currentA = ieA.Current;
                    double currentB = ieB.Current;

                    double deltaA = currentA - meanA;
                    double scaleDeltaA = deltaA / ++n;

                    double deltaB = currentB - meanB;
                    double scaleDeltaB = deltaB / n;

                    meanA += scaleDeltaA;
                    meanB += scaleDeltaB;

                    varA += scaleDeltaA * deltaA * (n - 1);
                    varB += scaleDeltaB * deltaB * (n - 1);
                    r += (deltaA * deltaB * (n - 1)) / n;
                }

                if (ieB.MoveNext())
                {
                    throw new ArgumentOutOfRangeException(nameof(dataA), "The array arguments must have the same length.");
                }
            }

            return r / Math.Sqrt(varA * varB);
        }

        /// <summary>
        /// Evaluates the rank of each entry of the unsorted data array.
        /// The rank definition can be specified to be compatible
        /// with an existing system.
        /// WARNING: Works inplace and can thus causes the data array to be reordered.
        /// </summary>
        public static double[] RanksInplace(double[] data)
        {
            var ranks = new double[data.Length];
            var index = new int[data.Length];

            for (int i = 0; i < index.Length; i++)
            {
                index[i] = i;
            }

            Sort(data, index);
            int previousIndex = 0;
            for (int i = 1; i < data.Length; i++)
            {
                if (Math.Abs(data[i] - data[previousIndex]) <= 0d)
                {
                    continue;
                }

                if (i == previousIndex + 1)
                {
                    ranks[index[previousIndex]] = i;
                }
                else
                {
                    RanksTies(ranks, index, previousIndex, i);
                }

                previousIndex = i;
            }

            RanksTies(ranks, index, previousIndex, data.Length);
            return ranks;
        }

        static void RanksTies(double[] ranks, int[] index, int a, int b)
        {
            // TODO: potential for PERF optimization
            double rank = (b + a - 1) / 2d + 1;

            for (int k = a; k < b; k++)
            {
                ranks[index[k]] = rank;
            }
        }

        /// <summary>
        /// Sort a list of keys and items with respect to the keys, in place using the quick sort algorithm.
        /// </summary>
        /// <typeparam name="TKey">The type of elements in the key list.</typeparam>
        /// <typeparam name="TItem">The type of elements in the item list.</typeparam>
        /// <param name="keys">List to sort.</param>
        /// <param name="items">List to permute the same way as the key list.</param>
        /// <param name="comparer">Comparison, defining the sort order.</param>
        public static void Sort<TKey, TItem>(IList<TKey> keys, IList<TItem> items)
        {
            int count = keys.Count;
            if (count <= 1)
            {
                return;
            }

            var comparer = Comparer<TKey>.Default;

            if (count == 2)
            {
                if (comparer.Compare(keys[0], keys[1]) > 0)
                {
                    Swap(keys, 0, 1);
                    Swap(items, 0, 1);
                }
                return;
            }

            // insertion sort
            if (count <= 10)
            {
                for (int i = 1; i < count; i++)
                {
                    var key = keys[i];
                    var item = items[i];
                    int j = i - 1;
                    while (j >= 0 && comparer.Compare(keys[j], key) > 0)
                    {
                        keys[j + 1] = keys[j];
                        items[j + 1] = items[j];
                        j--;
                    }
                    keys[j + 1] = key;
                    items[j + 1] = item;
                }
                return;
            }

            // array case
            if (keys is TKey[] keysArray && items is TItem[] itemsArray)
            {
                Array.Sort(keysArray, itemsArray, comparer);
                return;
            }

            // local sort implementation
            QuickSort(keys, items, comparer, 0, count - 1);
        }

        /// <summary>
        /// Recursive implementation for an in place quick sort on a list while reordering one other list accordingly.
        /// </summary>
        /// <typeparam name="T">The type of the list on which the quick sort is performed.</typeparam>
        /// <typeparam name="TItems">The type of the list which is automatically reordered accordingly.</typeparam>
        /// <param name="keys">The list which is sorted using quick sort.</param>
        /// <param name="items">The list which is automatically reordered accordingly.</param>
        /// <param name="comparer">The method with which to compare two elements of the quick sort.</param>
        /// <param name="left">The left boundary of the quick sort.</param>
        /// <param name="right">The right boundary of the quick sort.</param>
        static void QuickSort<T, TItems>(IList<T> keys, IList<TItems> items, IComparer<T> comparer, int left, int right)
        {
            do
            {
                // Pivoting
                int a = left;
                int b = right;
                int p = a + ((b - a) >> 1); // midpoint

                if (comparer.Compare(keys[a], keys[p]) > 0)
                {
                    Swap(keys, a, p);
                    Swap(items, a, p);
                }

                if (comparer.Compare(keys[a], keys[b]) > 0)
                {
                    Swap(keys, a, b);
                    Swap(items, a, b);
                }

                if (comparer.Compare(keys[p], keys[b]) > 0)
                {
                    Swap(keys, p, b);
                    Swap(items, p, b);
                }

                T pivot = keys[p];

                // Hoare Partitioning
                do
                {
                    while (comparer.Compare(keys[a], pivot) < 0)
                    {
                        a++;
                    }

                    while (comparer.Compare(pivot, keys[b]) < 0)
                    {
                        b--;
                    }

                    if (a > b)
                    {
                        break;
                    }

                    if (a < b)
                    {
                        Swap(keys, a, b);
                        Swap(items, a, b);
                    }

                    a++;
                    b--;
                } while (a <= b);

                // In order to limit the recursion depth to log(n), we sort the
                // shorter partition recursively and the longer partition iteratively.
                if ((b - left) <= (right - a))
                {
                    if (left < b)
                    {
                        QuickSort(keys, items, comparer, left, b);
                    }

                    left = a;
                }
                else
                {
                    if (a < right)
                    {
                        QuickSort(keys, items, comparer, a, right);
                    }

                    right = b;
                }
            } while (left < right);
        }

        /// <summary>
        /// Performs an in place swap of two elements in a list.
        /// </summary>
        /// <typeparam name="T">The type of elements stored in the list.</typeparam>
        /// <param name="keys">The list in which the elements are stored.</param>
        /// <param name="a">The index of the first element of the swap.</param>
        /// <param name="b">The index of the second element of the swap.</param>
        static void Swap<T>(IList<T> keys, int a, int b)
        {
            if (a == b)
            {
                return;
            }

            (keys[a], keys[b]) = (keys[b], keys[a]);
        }
    }
}
