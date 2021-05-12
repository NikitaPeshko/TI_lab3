using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Numerics;

namespace Rsa_link
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        public string PText
        {
            get { return textBox1.Text; }
        }

        public string QText
        {
            get { return textBox2.Text; }
        }
        public string EText
        {
            get { return textBox3.Text; }
        }
        public string DText
        {
            get { return textBox4.Text; }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
            
        }

        private void Form2_FormClosing(object sender, FormClosingEventArgs e)
        {
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "" || textBox2.Text == "")
            {
                label4.Text = "Поля P и Q обязательны для заполнения";
                return;
            }
            MathProblems math = new MathProblems(19);
            BigInteger p, q, E;

            if (!BigInteger.TryParse(textBox1.Text, out p) || !BigInteger.TryParse(textBox2.Text, out q))
            {
                label4.Text = "Ошибка, введено не число.";
                return;
            }
            if (!math.IsPossiblyPrim(p))
            {
                label4.Text = "Ошибка, число p не является простым.";
                return;
            }
            if (!math.IsPossiblyPrim(q))
            {
                label4.Text = "Ошибка, число q не является простым.";
                return;
            }

            if ((textBox3.Text != "" && textBox4.Text == "") || (textBox3.Text == "" && textBox4.Text != ""))
            {
                label4.Text = "Неккоректное количество аргументов.";
                return;
            }

            if (textBox3.Text != "")
            {
                if (!BigInteger.TryParse(textBox3.Text, out E))
                { 
                
                    label4.Text = "Ошибка(E), введено не число.";
                    return;

                }
                if (!math.IsPossiblyPrim(E))
                {
                    label4.Text = "Ошибка, число e не является простым.";
                    return;
                }

                BigInteger tmp = (p - 1) * (q - 1);

                if (tmp < E || BigInteger.GreatestCommonDivisor(tmp,E)>1)
                {
                    label4.Text = "Ошибка, число e неккоректно.";
                    return;
                }
                BigInteger d;
                if (!BigInteger.TryParse(textBox4.Text, out d))
                {

                    label4.Text = "Ошибка(D), введено не число.";
                    return;

                }
                if ( (d*E) % tmp !=1)
                {
                    label4.Text = "Ошибка, число d неккоректно.";
                    return;
                }

            }

            this.DialogResult = DialogResult.OK;
            this.Close();
        }
    }
}
