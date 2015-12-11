<cfajaximport tags="cfform" />

<h1>Demo of cfImageCropper custom tag by Todd Sharp (<a href="http://cfsilence.com">http://cfsilence.com</a>)</h1>
<h2>This demo shows using the custom tag with CF 8 Ajax features (cfwindow).</h2>

<!--- call the cf_imageCropperScriptImport tag to make sure JS is available --->

<cf_imageCropperScriptImport scriptSrc="/cfImageCropper/lib/" />
	
<cfwindow name="cropWindow" center="true" closable="true" resizable="false" width="550" height="750" 
	 draggable="true" initShow="false" modal="true" source="windowContents.cfm" refreshOnShow="true" />

<a href="javascript:void(0);" onclick="ColdFusion.Window.show('cropWindow');">Crop Image</a>
<br />
<cffile action="read" file="#expandPath("test.cfm")#" variable="thisCode" />

<p>Source code for this page:</p>
<textarea name="thisCode" style="width: 500px; height: 200px;">
<cfoutput>#htmlEditFormat(thisCode)#</cfoutput>
</textarea>