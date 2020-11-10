using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Extensions.Configuration;

namespace compose_test.Services
{

    public class WeatherService : IWeatherService
    {
        private readonly IConfiguration _config;

        public WeatherService(IConfiguration config)
        {
            _config = config;
        }

        public IDbConnection Connection
        {
            get
            {
                return new SqlConnection(_config.GetConnectionString("WeatherDatabaseConnectionString"));
            }
        }

        public async Task<List<SummaryModel>> GetSummaryAsync()
        {
            using (IDbConnection conn = Connection)
            {
                string query = "SELECT Id, Summary FROM dbo.Summary";
                conn.Open();
                var result = await conn.QueryAsync<SummaryModel>(query);
                return result.ToList();
            }
        }
    }
}
