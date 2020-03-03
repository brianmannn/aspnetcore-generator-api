using System;
using Xunit;
using System.Linq;
using api.Controllers;

namespace tests
{
    public class RangeTest
    {
        [Fact]
        public void CountShouldControllTheNumberOfResults()
        {
            var range = new api.Controllers.Range { Count = 3 };
            var generated = range.Of(() => string.Empty);
            Assert.Equal(3, generated.Count());
        }
    }
}
