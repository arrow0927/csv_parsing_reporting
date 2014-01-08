var dataset = [ 5, 10, 15, 20, 25, 23,56,78,23,34,34,45,56,67,78,85,45,34,23 ];

d3.select("body").selectAll("div")
      .data(dataset)
      .enter()
      .append("div")
      .attr("class", "bar")
      .style("height", function(current_val) {
     return current_val * 5 + "px";});

//Width and height
var dataset2 = [ 5, 10, 15, 20, 25 ];
var w = 500;
var h = 50;

var svg = d3.select("body")
            .append("svg")
            .attr("width", w)  
            .attr("height", h);

var circles = svg.selectAll("circle")
                 .data(dataset2)
                 .enter()
                 .append("circle");

circles.attr("cx", function(d, i) {
            return (i * 50) + 25;
        })
       .attr("cy", h/2)
       .attr("r", function(d) {
            return d;
       });