<!--- 
License:
cfImageCropper:
Copyright 2007 Todd Sharp
  
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 --->

<!--- attributes --->
<cfparam name="attributes.imageCropperName" default="" />
<cfparam name="attributes.scriptSrc" default="lib/" />
<cfparam name="attributes.imgSrc" default="" />
<cfparam name="attributes.imgAlt" default="" />
<cfparam name="attributes.minWidth" default="" />
<cfparam name="attributes.minHeight" default="" />
<cfparam name="attributes.maxWidth" default="" />
<cfparam name="attributes.maxHeight" default="" />
<cfparam name="attributes.displayOnInit" default="false" />
<cfparam name="attributes.xRatioDim" default="" />
<cfparam name="attributes.yRatioDim" default="" />
<cfparam name="attributes.captureKeys" default="false" /><!--- i'm really not even sure what the heck this is --->
<cfparam name="attributes.x1onLoad" default="" />
<cfparam name="attributes.x2onLoad" default="" />
<cfparam name="attributes.y1onLoad" default="" />
<cfparam name="attributes.y2onLoad" default="" />
<!--- <cfparam name="attributes.onEndCrop" default="" /> is there a need to expose this? --->

<!--- misc vars --->
<cfparam name="request.scriptsExist" default="false">
<cfparam name="variables.wrapperClass" default="wrap_#replace(createUUID(), "-", "", "all")#">

<cfif thisTag.ExecutionMode is 'start'>

	<!--- validation --->
	
	<!--- 	
	i don't want to limit it to cfform, but the basetaglist does not show <form>...
	<cfset baseTags = getBaseTagList()>
	<cfif not listFindNoCase(baseTags,"cfform")>
		<cfthrow type="cf_imageCropper" message="The cf_imageCropper tag must be nested within a form or cfform.">
	</cfif> 
	--->
	
	<cfif not directoryExists(expandPath(attributes.scriptSrc))>
		<cfthrow type="cf_imageCropper" message="The directory specified as your scriptSrc (#attributes.scriptSrc#) does not exist.">
	</cfif>
	<cfif not len(attributes.imageCropperName)>
		<cfthrow type="cf_imageCropper" message="Name is required.">	
	</cfif>
	<cfif not len(attributes.imgSrc)>
		<cfthrow type="cf_imageCropper" message="imgSrc is required.">	
	</cfif>
	<cfif not fileExists(expandPath(attributes.imgSrc))>
		<cfthrow type="cf_imageCropper" message="The image specified as your imgSrc (#attributes.imgSrc#) does not exist.">
	</cfif>
	<!--- 
	the next check can be added but will require coldfusion 8 
	<cfif not isImageFile(attributes.imgSrc)>
		<cfthrow type="cf_imageCropper" message="The image specified as your imgSrc (#attributes.imgSrc#) is not a valid image file.">
	</cfif>
	--->
	<cfif len(attributes.minWidth) and not isNumeric(attributes.minWidth)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute minWidth which is currently '#attributes.minWidth#' must be numeric.">
	</cfif>
	<cfif len(attributes.minHeight) and not isNumeric(attributes.minHeight)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute minHeight which is currently '#attributes.minHeight#' must be numeric.">
	</cfif>
	<cfif len(attributes.maxWidth) and not isNumeric(attributes.maxWidth)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute maxWidth which is currently '#attributes.maxWidth#' must be numeric.">
	</cfif>
	<cfif len(attributes.maxHeight) and not isNumeric(attributes.maxHeight)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute maxHeight which is currently '#attributes.maxHeight#' must be numeric.">
	</cfif>	
	<cfif not isBoolean(attributes.displayOnInit)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute displayOnInit which is currently '#attributes.displayOnInit#' must be boolean.">
	</cfif>		
	<cfif len(attributes.xRatioDim) and not isNumeric(attributes.xRatioDim)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute xRatioDim which is currently '#attributes.xRatioDim#' must be numeric.">
	</cfif>
	<cfif len(attributes.yRatioDim) and not isNumeric(attributes.yRatioDim)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute yRatioDim which is currently '#attributes.yRatioDim#' must be numeric.">
	</cfif>
	
	<cfif len(attributes.x1onLoad) and not isNumeric(attributes.x1onLoad)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute x1onLoad which is currently '#attributes.x1onLoad#' must be numeric.">
	</cfif>
	<cfif len(attributes.x2onLoad) and not isNumeric(attributes.x2onLoad)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute x2onLoad which is currently '#attributes.x2onLoad#' must be numeric.">
	</cfif>	
	<cfif len(attributes.y1onLoad) and not isNumeric(attributes.y1onLoad)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute y1onLoad which is currently '#attributes.y1onLoad#' must be numeric.">
	</cfif>	
	<cfif len(attributes.y2onLoad) and not isNumeric(attributes.y2onLoad)>
		<cfthrow type="cf_imageCropper" message="The value of the attribute yRatioDim which is currently '#attributes.y2onLoad#' must be numeric.">
	</cfif>	
		
	<cfoutput>
	<!--- scripts need to be included? (this will ensure they're only done once per request) --->
	<cfif not request.scriptsExist>
		<cfsavecontent variable="js">
		<script src="#attributes.scriptSrc#prototype.js" type="text/javascript"></script>	
		<script src="#attributes.scriptSrc#scriptaculous.js?load=builder,dragdrop" type="text/javascript"></script>
		<script src="#attributes.scriptSrc#cropper.js" type="text/javascript"></script>
		<!--- include style for wrapper --->
		<style type="text/css">
			.#variables.wrapperClass# {
				margin: 0 0 0 0; /* not sure why this is needed but it gets goofy if it aint here */
			}
		</style>
		</cfsavecontent>
		<cfhtmlhead text="#js#" />
		<cfset request.scriptsExist = true />
	</cfif>
	
	
	<script type="text/javascript" charset="utf-8">
		
		// setup the callback function
		onEndCrop = function( coords, dimensions ) {
			$( '#attributes.imageCropperName#_x1' ).value = coords.x1;
			$( '#attributes.imageCropperName#_y1' ).value = coords.y1;
			$( '#attributes.imageCropperName#_x2' ).value = coords.x2;
			$( '#attributes.imageCropperName#_y2' ).value = coords.y2;
			$( '#attributes.imageCropperName#_width' ).value = dimensions.width;
			$( '#attributes.imageCropperName#_height' ).value = dimensions.height;
		}
		cropper = function() { 
			new Cropper.Img( 
				'#attributes.imageCropperName#',
				{
					onEndCrop: onEndCrop
					<cfif len(attributes.minWidth)>
					,minWidth: #attributes.minWidth#
					</cfif> 
					<cfif len(attributes.minHeight)>
					,minHeight: #attributes.minHeight#
					</cfif>
					<cfif len(attributes.maxHeight)>
					,maxHeight: #attributes.maxHeight#
					</cfif>
					<cfif len(attributes.maxWidth)>
					,maxWidth: #attributes.maxWidth#
					</cfif>
					<cfif len(attributes.displayOnInit)>
					,displayOnInit: #attributes.displayOnInit#	
					</cfif>
					<cfif len(attributes.xRatioDim) and len(attributes.yRatioDim)>
					,ratioDim: { x: #attributes.xRatioDim#, y: #attributes.yRatioDim# }
					</cfif>		
					<cfif len(attributes.captureKeys)>
					,captureKeys: #attributes.captureKeys#
					</cfif>		
					<cfif len(attributes.x1onLoad) and len(attributes.x2onLoad) and len(attributes.y1onLoad) and len(attributes.y2onLoad)>
					,onloadCoords: { x1: #attributes.x1onLoad#, y1: #attributes.y1onLoad#, x2: #attributes.x2onLoad#, y2: #attributes.y2onLoad# }
					</cfif>
				}
			) 
		}
		
		// set up cropper

		Event.observe( 
			window, 
			'load', 
			cropper
		);
		
	</script>
	
		
	<div id="#attributes.imageCropperName#_cropperWrap" class="#variables.wrapperClass#">
		<img src="#attributes.imgSrc#" alt="#attributes.imgAlt#" id="#attributes.imageCropperName#" />
	</div>
	<input type="hidden" name="#attributes.imageCropperName#_x1" id="#attributes.imageCropperName#_x1" />
	<input type="hidden" name="#attributes.imageCropperName#_y1" id="#attributes.imageCropperName#_y1" />
	<input type="hidden" name="#attributes.imageCropperName#_x2" id="#attributes.imageCropperName#_x2" />
	<input type="hidden" name="#attributes.imageCropperName#_y2" id="#attributes.imageCropperName#_y2" />
	<input type="hidden" name="#attributes.imageCropperName#_width" id="#attributes.imageCropperName#_width" />
	<input type="hidden" name="#attributes.imageCropperName#_height" id="#attributes.imageCropperName#_height" />
	  
	</cfoutput>
<cfelse>
	<cfexit method="exittag" />
</cfif>



