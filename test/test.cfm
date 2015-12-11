<h1>Demo of cfImageCropper custom tag by Todd Sharp (<a href="http://cfsilence.com">http://cfsilence.com</a>)</h1>
<h2>Click and drag on the original image to crop, then submit to see the cropped image</h2>

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

<form name="testForm" method="post">
	<cf_imageCropper imageCropperName="testimage" scriptSrc="/cfImageCropper/lib/" imgSrc="castle.jpg" />
	<br />
	<input type="submit" name="submit" value="Crop This Image!" style="font-weight:bold;" />
</form>

<cffile action="read" file="#expandPath("test.cfm")#" variable="thisCode" />

<p>Source code for this page:</p>

<textarea name="thisCode" style="width: 700px; height: 200px;">
<cfoutput>#htmlEditFormat(thisCode)#</cfoutput>
</textarea>