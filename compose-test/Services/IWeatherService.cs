using System.Collections.Generic;
using System.Threading.Tasks;

namespace compose_test.Services
{
    public interface IWeatherService
    {
        Task<List<SummaryModel>> GetSummaryAsync();
    }
}