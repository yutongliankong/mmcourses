<!--- Walkthrough 7-4 --->
<cfimport taglib="taglibs-image.jar" prefix="img">
<html>
<body>
Original Image <br>
<img src="images/seating_chart.jpg">
<br>
New Image<br>
<!--- Place your IMG tags here--->
<img:image src="images/sreating_chart.jpg" name="splash-new-gray7.jpg" attributes="border='0'" alt="a sample dynamic image" refresh="true">
<img:text text="We're FULL!" x="25%" y="50%" font="Arial" bold="true" size="12" color="0xff0000"/>
</img:image>
</body>
</html>


