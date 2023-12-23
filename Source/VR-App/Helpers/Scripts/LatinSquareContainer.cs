namespace Assets.Helpers.Scripts
{	
    public static class LatinSquareContainer
    {
		/// Source: statpages.info
		/// Author: Oliver Sailer		
		/// Link: https://statpages.info/latinsq.html		
		/// Remark: Original code has been changed.		
        public static readonly uint[,] BalancedLatinSquare12 = new uint[,]
                                                                {
                                                                    {0, 1, 11, 2, 10, 3, 9, 4, 8, 5, 7, 6},
                                                                    {1, 2, 0, 3, 11, 4, 10, 5, 9, 6, 8, 7},
                                                                    {2, 3, 1, 4, 0, 5, 11, 6, 10, 7, 9, 8},
                                                                    {3, 4, 2, 5, 1, 6, 0, 7, 11, 8, 10, 9},
                                                                    {4, 5, 3, 6, 2, 7, 1, 8, 0, 9, 11, 10},
                                                                    {5, 6, 4, 7, 3, 8, 2, 9, 1, 10, 0, 11},
                                                                    {6, 7, 5, 8, 4, 9, 3, 10, 2, 11, 1, 0},
                                                                    {7, 8, 6, 9, 5, 10, 4, 11, 3, 0, 2, 1},
                                                                    {8, 9, 7, 10, 6, 11, 5, 0, 4, 1, 3, 2},
                                                                    {9, 10, 8, 11, 7, 0, 6, 1, 5, 2, 4, 3},
                                                                    {10, 11, 9, 0, 8, 1, 7, 2, 6, 3, 5, 4},
                                                                    {11, 0, 10, 1, 9, 2, 8, 3, 7, 4, 6, 5}
                                                                };
    }
}