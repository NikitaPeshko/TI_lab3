using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Rsa_link
{
    class MathProblems
    {
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


        static public int func_phi(int n) // функция Эйлера
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
        //возведение в степент 
        private static int Powmod(int a, int b, int p)
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

        //Алгоритм эвклида
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

        // Расширенный алг. эвклида
        public static int gcd(int a, int b, ref int x, ref int y)
        {
            if (a == 0)
            {
                x = 0; y = 1;
                return b;
            }
            int x1, y1;
            int d = gcd(b % a, a, x1, y1);
            x = y1 - (b / a) * x1;
            y = x1;
            return d;
        }

        public static int GetOpposite (int a, int m)
        {
            int x, y;
            int g = gcd(a, m, x, y);
            if (g != 1)
                return null;
            else
            {
                x = (x % m + m) % m;
                return x;
            }
        }


        // Факторизация числа x
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



    }
}
