using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Numerics;
using System.Threading;
using System.IO;

namespace Rsa_link
{
    class Rsa_encrypter
    {
        private BigInteger SimpN1, SimpN2;
        private BigInteger Module;
        private BigInteger phi;
        private BigInteger e;
        private BigInteger d;


        public BigInteger GetFileHash(string path)
        {
            BigInteger res = 0;
            try
            {
                FileStream F = new FileStream(path, FileMode.Open, FileAccess.Read);
                int border = int.MaxValue - 10000;
                byte[] arr = new byte[64000];
                int byteread = 0;
                int tmp =0;
                do
                {
                    byteread = F.Read(arr, 0, 64000);
                    for (int i = 0; i < byteread; i += 10)
                    {
                        tmp += arr[i];
                        if (tmp > border)
                        {
                            res += tmp;
                            tmp = 0;
                        }

                    }
                }
                while (byteread > 0);
                res += tmp;
                F.Close();

            }
            catch
            {

            }
            


            return res;
        }


        public bool CreateSign(string file_path, string sign_path)
        {
            try
            {
                BigInteger b = this.GetFileHash(file_path);
                b = this.EncryptNumber(b);
                byte[] tmp = b.ToByteArray();

                FileStream f = new FileStream(sign_path, FileMode.Create,FileAccess.Write);
                f.Write(tmp, 0, tmp.Length);
                f.Close();
                return true;
            }
            catch {
                return false;
            }


        }
        

        public bool CheckSign(string file_path, string sign_path)
        {
            try
            {
                BigInteger b = this.GetFileHash(file_path);

               byte [] tmp = new byte[4048];
                FileStream f = new FileStream(sign_path, FileMode.Open, FileAccess.Read);
                int ByteRead = f.Read(tmp, 0, tmp.Length);
                f.Close();
                byte[] numb = new byte[ByteRead];
                Array.Copy(tmp, numb, ByteRead);
                BigInteger OldHash = new BigInteger(numb);

                OldHash = this.DecryptNumber(OldHash);
                if (OldHash == b)
                {
                    return true;
                }
                else
                    return false;        
            }
            catch
            {
                return false;
            }


        }

        public BigInteger P
        {
            get { return SimpN1; }
        }
        public BigInteger Q
        {
            get { return SimpN2; }
        }
        public BigInteger N
        {
            get { return Module; }
        }

        public BigInteger E
        {
            get { return e; }
        }
        public BigInteger D
        {
            get { return d; }
        }

        public bool GenerateKeys(int len)
        {
            

            try
            {
                var math = new MathProblems(50);
                math.k = 15;

                SimpN1 = math.GetPrimNumber(len/2);
                Thread.Sleep(10);
                SimpN2 = math.GetPrimNumber(len/2);
                while (SimpN2 == SimpN1)
                    SimpN2 = math.GetPrimNumber(len / 2);
                Module = SimpN1 * SimpN2;
                phi = (SimpN1 - 1) * (SimpN2 - 1);
                e = FindE(phi, len, math);
                d = MathProblems.GetOpposite(e, phi);
                return true;
            }
            catch
            {
                return false;
            }

        }

        public bool GenerateKeys(string p, string q)
        {
            try
            {
                var math = new MathProblems(50);
                math.k = 15;

                SimpN1 = BigInteger.Parse(p);
                
                SimpN2 = BigInteger.Parse(q);
                Module = SimpN1 * SimpN2;
                phi = (SimpN1 - 1) * (SimpN2 - 1);
                e = FindE(phi, p.Length*2, math);
                d = MathProblems.GetOpposite(e, phi);
                return true;
            }
            catch
            {
                return false;
            } 
        }
        public bool GenerateKeys(string[] par)
        {

            try
            {
                var math = new MathProblems(50);
                math.k = 15;
                if (par.Length < 4)
                    return false;
                SimpN1 = BigInteger.Parse(par[0]);

                SimpN2 = BigInteger.Parse(par[1]);
                Module = SimpN1 * SimpN2;
                phi = (SimpN1 - 1) * (SimpN2 - 1);
                e = BigInteger.Parse(par[2]);
                d = BigInteger.Parse(par[3]);
                return true;
            }
            catch
            {
                return false;
            }

        }



        BigInteger FindE(BigInteger phi, int len, MathProblems math)
        {
            BigInteger e = 157;
            do
            {
                if (len < 5)
                    e = math.GetPrimNumber(len -1 );
                else
                    e = math.GetPrimNumber(len - 3);
                
            }
            while (BigInteger.GreatestCommonDivisor(phi, e) != 1);          
            return e;
        }

       
        public void EncryptData(byte[] data, int len, string path)
        {

        }
        public BigInteger EncryptNumber(BigInteger N)
        {

              return BigInteger.ModPow(N, e,Module);
        }
        public BigInteger DecryptNumber(BigInteger N)
        {
             return BigInteger.ModPow(N, d, Module);
            
        }



    }
}
