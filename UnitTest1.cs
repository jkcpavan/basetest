using NUnit.Framework;
using System;
using OpenQA.Selenium;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;
using System.IO;
using System.Reflection;
namespace basetest
{
    public class Tests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void Test1()
        {
       // using (IWebDriver driver = new FirefoxDriver(@"../../../"))
        //{
          //  WebDriverWait wait = new WebDriverWait(driver, TimeSpan.FromSeconds(10));
            //driver.Navigate().GoToUrl("https://www.google.com/ncr");
            //driver.FindElement(By.Name("q")).SendKeys("cheese" + Keys.Enter);
            //IWebElement firstResult = wait.Until(ExpectedConditions.ElementExists(By.CssSelector("h3>div")));
            //Console.WriteLine(firstResult.GetAttribute("textContent"));
        //}

         using (IWebDriver driver = new ChromeDriver(@"/usr/bin"))
        {
            WebDriverWait wait = new WebDriverWait(driver, TimeSpan.FromSeconds(10));
            driver.Navigate().GoToUrl("https://www.google.com/ncr");
            driver.FindElement(By.Name("q")).SendKeys("cheese" + Keys.Enter);
            IWebElement firstResult = wait.Until(ExpectedConditions.ElementExists(By.CssSelector("h3>div")));
            Console.WriteLine(firstResult.GetAttribute("textContent"));
        }
            Assert.Pass();
        }
    }
}