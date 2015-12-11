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

<!--- 
this is a convenience tag that is helpful when using the cf_imageCropper
custom tag with ColdFusion 8 Ajax functionality.
for example, lets say you wanted the imageCropper in a cfwindow - 
you'd call the cf_imageCropperScriptImport tag (with no attributes)
on your main template and the window tag would simply call cf_imageCropper normally.
you'd also need to use the JS helper 'cfImageCropper.load' in an ajaxOnLoad to init the crop tool
--->

<cfparam name="attributes.scriptSrc" default="lib/" />
<cfparam name="variables.wrapperClass" default="wrap_#replace(createUUID(), "-", "", "all")#">

<cfif thisTag.ExecutionMode is 'start'>
	<cfparam name="request.scriptsExist" default="false" />
	<cfif not request.scriptsExist>
		<cfoutput>
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
			<script type="text/javascript">
			//create an API that can be called to init the cropper (when used with ajaxy goodness)
			var cfImageCropper = [];
			
			cfImageCropper.load = function(){
				cropper();
			}
			</script>
			</cfsavecontent>
			<cfhtmlhead text="#js#" />
		</cfoutput>
		<cfset request.scriptsExist = true />
	</cfif>
<cfelse>
	<cfexit method="exittag" />
</cfif>