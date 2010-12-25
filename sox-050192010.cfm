<!---
	Some old quick CF code ... a quick example though to 
	easily convert to PHP or SSJS.
--->

<cfscript>

	day = dateformat(now(),"dd");
	day = "16";
	month = dateformat(now(),"mm");
	year = dateformat(now(), "yyyy");

	rooturl = "http://gd2.mlb.com/components/game/mlb/year_#year#/month_#month#/day_#day#/";

</cfscript>
 
<b>sox, 5/19</b><hr>

<cfhttp 
url="http://gd2.mlb.com/components/game/mlb/year_2010/month_05/day_19/gid_2010_05_19_minmlb_bosmlb_1/inning/inning_1.xml">

<cfset xml=cfhttp.filecontent.toString()>

<cfset x = xmlParse(xml)>

<cfset halfs = "top,bottom">

<cfloop list="#halfs#" index="half">
	
	<cfset aAtBats = xmlsearch(x, "/inning/#half#/atbat")>
	
	<cfset count=arraylen(aAtBats)>
	
	<cfoutput>
	<h2>#half#</h2>

	<cfloop from="1" to="#count#" index="i">
		<cfset ab = aAtBats[i]["XmlAttributes"]>
		<cfset e = aAtBats[i]["XmlChildren"]>
		AB: #i#<br>
		Batter: #ab.batter#<br>
		Pitcher: #ab.pitcher#<br>
		Event: #ab.event#<br>
		Description: #ab.des#<br>
		Pitches:
		<cfset pitches = xmlSearch(aAtBats[i], "pitch")>
		<ul>
		<cfloop from="1" to="#arraylen(pitches)#" index="p">
	
			<cfset pitch = pitches[p]["XmlAttributes"]>
			<li> <cfif isdefined("pitch.type")>#pitch.type#<cfelse>???</cfif> : 
			<cfif isdefined("pitch.des")>#pitch.des#<cfelse>????</cfif> 
				<cfif isdefined("pitch.end_speed")>: #pitch.end_speed#mph<cfelse>????</cfif>
				<cfif isdefined("pitch.pitch_type")>#pitch.pitch_type#<cfelse>????</cfif>
		</cfloop>
		</ul>
		<hr>
	</cfloop>
	</cfoutput>
</cfloop>
