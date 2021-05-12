using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Numerics;
using System.Threading;

namespace Rsa_link
{
    class MathProblems
    {
        public int k = 50;
        private int PrimeCount = 0;
        private int[] PrimeNums;


        public MathProblems(int count)
        {
            PrimeCount = count;
            if (PrimeCount > 500)
                PrimeCount = 500;
            int len = 4000;
            bool[] Primes = new bool[len];
            for (int i = 2; i < len; i++)           
                Primes[i] = true;
            
            for (int i = 2; i < len; i++)
            {
                if (!Primes[i])
                    continue;  
                for (int j = i + i; j < len; j += i)
                {
                    Primes[j] = false;
                }
            }
            int k = 0;
            PrimeNums = new int[PrimeCount];

            for (int i = 3; i < len; i++)
            {
                if (!Primes[i])
                    continue;
                PrimeNums[k] = i;
                k++;
                if (PrimeCount == k)
                    break;


            }
            if (PrimeCount != k)
                PrimeCount = k;


        }

        public static List<int> GetG(int p)
        {
            int i, phi = func_phi(p), n = phi;
            List<int> results = new List<int>();
            List<int> fact = Factorization(n);

            bool ok;
            for (int res = 2; res <= p - 1; ++res)
            {
                if ((GetNOD(res, p) != 1))
                    continue;

                ok = true;
                for (i = 0; i < fact.Count; i++)
                {
                    if (Powmod(res, phi / fact[i], p) == 1)
                    {
                        ok = false;
                        break;
                    }
                }


                if (ok)
                    results.Add(res);
            }

            return results;
        }


        static int func_phi(int n) // функция Эйлера
        {
            int ret = 1;
            for (int i = 2; i * i <= n; ++i)
            {
                int p = 1;
                while (n % i == 0)
                {
                    p *= i;
                    n /= i;
                }
                p /= i;
                if (p >= 1)
                    ret *= p * (i - 1);
            }

            n--;
            if (n != 0)
            {
                return n * ret;

            }
            else
                return ret;
        }
      
        public static int Powmod(int a, int b, int p)
        {

            int res = 1;
            while (b != 0)
            {
                if ((b & 1) != 0)
                {
                    res = (int)(res * 1 * a % p);
                    b--;

                }
                else
                {
                    a = (int)(a * 1 * a % p);
                    b >>= 1;
                }
            }

            return res;


        }

        /*
        public static BigInteger Powmod_Big( BigInteger a, BigInteger b, BigInteger p)
        {

            BigInteger res = 1;
            while (b != 0)
            {
                if ((b & 1) != 0)
                {
                    res = (int)(res * 1 * a % p);
                    b--;

                }
                else
                {
                    a = (int)(a * 1 * a % p);
                    b >>= 1;
                }
            }

            return res;


        }
        */


        
        public static int GetNOD(int val1, int val2)
        {
            while ((val1 != 0) && (val2 != 0))
            {
                if (val1 > val2)
                    val1 %= val2;
                else
                    val2 %= val1;
            }
            return Math.Max(val1, val2);
        }

        
        private static List<int> Factorization(int x)
        {
            int i;
            List<int> Fact = new List<int>();
            for (i = 2; i * i <= x; i++)
            {
                if (x % i == 0)
                {
                    Fact.Add(i);
                    while (x % i == 0)
                        x /= i;
                }
            }
            if (x > 1)
                Fact.Add(x);
            return Fact;
        }




        
        public static int gcd(int a, int b, ref int x, ref int y)
        {
            if (a == 0)
            {
                x = 0; y = 1;
                return b;
            }
            int x1 =0, y1 = 0;
            int d = gcd(b % a, a, ref x1, ref y1);
            x = y1 - (b / a) * x1;
            y = x1;
            return d;
        }

        public static int GetOpposite(int a, int m)
        {
            int x =0, y=0;
            int g = gcd(a, m, ref x, ref y);
            if (g != 1)
                return 0;
            else
            {
                x = (x % m + m) % m;
                return x;
            }
        }


        
        public static BigInteger gcd(BigInteger a, BigInteger b, ref BigInteger x, ref BigInteger y)
        {
            if (a == 0)
            {
                x = 0; y = 1;
                return b;
            }
            BigInteger x1 = 0, y1 = 0;
            BigInteger d = gcd(b % a, a, ref x1, ref y1);
            x = y1 - (b / a) * x1;
            y = x1;
            return d;
        }

        public static BigInteger GetOpposite(BigInteger a, BigInteger m)
        {
            BigInteger x = 0, y = 0;
            BigInteger g = gcd(a, m, ref x, ref y);
            if (g != 1)
                return 0;
            else
            {
                x = (x % m + m) % m;
                return x;
            }
        }


        public bool IsPossiblyPrim(int n)
        {
            
            int tmp = n - 1, s = 0;

            while (tmp % 2 == 0)
            {
                tmp = tmp / 2;
                s++;          
            }

            var rand = new Random();
            int r,x;
            for (int i = 0; i < k; i++)
            {
                r = rand.Next(2, n-2);
                x = Powmod(r, tmp, n);
                if ((x == 1) || (x == n - 1))
                    continue;

                bool flag = false;
                for (int j = 0; j < s - 1; j++)
                {
                    x = Powmod(x, 2, n);
                    if (x == 1)
                        return false;
                    if (x == n - 1)
                    {
                        flag = true;
                        break;
                    }

                }

                if (flag)
                    continue;
                return false;
            }

            return true;
        }



        public bool IsPossiblyPrim(BigInteger n)
        {
            if (n % 2 == 0)
                return false;

            for (int i = 0; i < PrimeCount; i++)
            {
                if (BigInteger.GreatestCommonDivisor(n,PrimeNums[i]) !=1)
                    return false;

            }

            int  s = 0;
            BigInteger tmp = n - 1;

            while (tmp % 2 == 0)
            {
                tmp = tmp / 2;
                s++;
            }

            var rand = new Random();
            BigInteger r, x;
            for (int i = 0; i < k; i++)
            {
                if (n > int.MaxValue)
                    r = rand.Next(2, int.MaxValue);
                else
                    r = rand.Next(2, (int)n-2);
                x = BigInteger.ModPow(r,tmp,n);
                    
                if ((x == 1) || (x == n - 1))
                    continue;

                bool flag = false;
                for (int j = 0; j < s - 1; j++)
                {
                    x = BigInteger.ModPow(x, 2, n);
                    if (x == 1)
                        return false;
                    if (x == n - 1)
                    {
                        flag = true;
                        break;
                    }



                }

                if (flag)
                    continue;
                return false;

            }

            return true;

        }



        public BigInteger GetNumber(int size)
        {
            BigInteger result = 0;
            
            Random r = new Random();
            while (size >= 3)
            {

                result = result * 1000 + r.Next(100, 999);
                size -= 3;
                
            }
            if (size == 2)
            {
                result = result * 100 + r.Next(10, 99);       
            }
            if (size == 1)
            {
                result = result * 10 + r.Next(1, 9);
            }

            return result;
        }

        public BigInteger GetPrimNumber(int size)
        {
            BigInteger res=0;
            bool flag = false;

            while (!flag)
            {
                res = GetNumber(size);
                if (res % 2 == 0)
                {
                    res += 1;
                }
                flag = IsPossiblyPrim(res);

            }
            return res;
        }

    }
}
