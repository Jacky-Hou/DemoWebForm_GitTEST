using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class DateTimeHelper
    {
        public bool IsDate(string text) { DateTime _out; return DateTime.TryParse(text, out _out); }
    }
}
