var pie_width  = 960,
    pie_height = 500,
    pie_radius = Math.min(pie_width, pie_height) / 2;

var pie_color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var pie_arc = d3.svg.arc()
    .outerRadius(pie_radius - 10)
    .innerRadius(0);

var pie = d3.layout.pie()
    .sort(null)
    .value(function(pie_d) { return pie_d.population; });

var svg = d3.select(".pie_chart").append("svg")
    .attr("class", "pie_svg")
    .attr("width", pie_width)
    .attr("height", pie_height)
  .append("g")
    .attr("transform", "translate(" + pie_width / 2 + "," + pie_height / 2 + ")");

d3.csv("http://0.0.0.0:3000/pie_chart.csv", function(error, data) {

  data.forEach(function(pie_d) {
    pie_d.population = +pie_d.population;
  });

  var g = d3.select(".pie_chart g").selectAll(".pie_arc")
      .data(pie(data))
    .enter().append("g")
      .attr("class", "pie_arc");

  g.append("path")
      .attr("d", pie_arc)
      .style("fill", function(pie_d) { return pie_color(pie_d.data.age); });

  g.append("text")
      .attr("transform", function(pie_d) { return "translate(" + pie_arc.centroid(pie_d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(pie_d) { return pie_d.data.age; });

});