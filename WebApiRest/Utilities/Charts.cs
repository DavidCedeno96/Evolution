using WebApiRest.Models;

namespace WebApiRest.Utilities
{
    public static class Charts
    {

        public static DatasetPuntosList ChartPuntos(ChartPuntosList chartList)
        {
            DatasetPuntosList datasetList = new() { Lista = new() };

            Random random = new();

            var gruposPorAño = chartList.Lista.GroupBy(ob => ob.Año).ToList();

            foreach (var item in gruposPorAño)
            {
                int r = random.Next(256);
                int g = random.Next(256);
                int b = random.Next(256);
                int index = 0;

                var j = item;

                List<int> dataList = new();
                for (int i = 0; i < 12; i++)
                {
                    dataList.Add(0);
                }

                foreach (var ob in item)
                {
                    index = ob.Mes - 1;
                    dataList[index] += ob.Puntos;
                }

                for (int i = 0; i < dataList.Count; i++)
                {
                    if (i > index)
                    {
                        dataList[i] = -1;
                    }
                }

                dataList.RemoveAll(x => x == -1);

                datasetList.Lista.Add(new DatasetPuntos()
                {
                    Label = $"año {item.Key}",
                    Data = dataList,
                    Fill = false,
                    BorderColor = $"rgb({r}, {g}, {b})",
                    Tension = 0.1
                });
            }
            datasetList.Error = chartList.Error;
            datasetList.Info = chartList.Info;

            return datasetList;
        }
    }
}
