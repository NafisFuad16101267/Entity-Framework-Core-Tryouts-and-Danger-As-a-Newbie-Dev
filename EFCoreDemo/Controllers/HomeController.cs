using EFCoreDemo.Models;
using EFDataAccessLibrary;
using EFDataAccessLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using System.Text.Json;

namespace EFCoreDemo.Controllers
{
    public class HomeController : Controller
    {
        PeopleContext _peopleContext;

        public HomeController(PeopleContext peopleContext) 
        {
            _peopleContext = peopleContext;
        }

        public IActionResult Index()
        {
            LoadSampleData();
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        private void LoadSampleData()
        {
            if (_peopleContext.Person.Count() == 0) 
            {
                string file = System.IO.File.ReadAllText("generated.json");
                var people = JsonSerializer.Deserialize<List<Person>>(file);
                _peopleContext.AddRange(people);
                _peopleContext.SaveChanges();
            }

            var peoples = _peopleContext.Person
                            .Include(person => person.Emails)
                            .Include(person => person.Addresses)
                            .ToList()
                            .Where(person => (person.Age >= 18 && person.Age <= 65));
        }
    }
}
