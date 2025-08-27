const ctx = document.getElementById('chart1');

new Chart(ctx, {
  type: 'bar',
  data: {
    labels: chart1labels,
    datasets: [{
      label: 'Траты в месяц',
      data: chart1data,
      borderWidth: 1,
      backgroundColor: '#57A0FA',
      borderColor: '#333'
    }]
  },
  options: {
    scales: {
      y: {
        beginAtZero: true
      }
    }
  }
});

const ctx2 = document.getElementById('chart2');

new Chart(ctx2, {
  type: 'pie',
  data: {
    labels: chart2labels,
    datasets: [{
      label: 'Траты за месяц по категориям',
      data: chart2data,
      borderWidth: 1
    }]
  },
  options: {
    scales: {
      y: {
        beginAtZero: true
      }
    }
  }
});