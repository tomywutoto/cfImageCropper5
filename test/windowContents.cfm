<cfif isDefined("form.submit")>
	<cfdump var="#form#" label="Form fields created by the cf_imageCropper custom tag.">
	<cfif testimage_height neq 0 and testimage_width neq 0>
		<cfimage action = "read" source="#expandPath("castle.jpg")#" name="img" />
		<cfset imageCrop(img, form.testimage_x1, form.testimage_y1, testimage_width, form.testimage_height)>
		<p><strong>Cropped Image</strong></p>
		<cfimage action="writeToBrowser" source="#img#" />
	<cfelse>
		<p>you didn't select a crop area...</p>
	</cfif>
</cfif>

<p><strong>Original Image</strong></p>

<cfform name="testForm" method="post">
	<cfimage action="read" source="#expandPath("castle.jpg")#" name="myImg" />
	
	<cfset x1Onload = (myImg.width / 2) - 50 />
	<cfset x2Onload = (myImg.width / 2) + 50 />
	<cfset y1Onload = (myImg.height / 2) - 50 />
	<cfset y2Onload = (myImg.height / 2) + 50 />
	
	<cf_imageCropper imageCropperName="testimage" scriptSrc="/cfImageCropper/lib/" 
			displayOnInit="true" imgSrc="castle.jpg" minWidth="100" maxWidth="100" minHeight="100" maxHeight="100"
			x1OnLoad="#x1Onload#" x2OnLoad="#x2Onload#" y1OnLoad="#y1Onload#" y2OnLoad="#y2Onload#" />
	<br />
	<input type="submit" name="submit" value="Crop This Image!" style="font-weight:bold;" />

</cfform>

<cfset ajaxOnLoad('cfImageCropper.load') />

<cffile action="read" file="#expandPath(cgi.script_name)#" variable="thisCode" />

<p>Source code for this page:</p>
<textarea name="thisCode" style="width: 700px; height: 200px;">
<cfoutput>#htmlEditFormat(thisCode)#</cfoutput>
</textarea>