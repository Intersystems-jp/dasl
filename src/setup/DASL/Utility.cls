Class DASL.Utility Extends %Base
{

ClassMethod ConvertFileEncoding(pInputfile As %String, pOutputfile As %String, pInputEncode As %String, pOutputEnode As %String) As %Status
{
    set status = $$$OK
    
	set inputstream = ##class(%Stream.FileCharacter).%New()
	set inputstream.TranslateTable = pInputEncode
	set status = inputstream.LinkToFile(pInputfile)
	set outputstream = ##class(%Stream.FileCharacter).%New()
	set outputstream.TranslateTable = pOutputEnode
	set status = outputstream.LinkToFile(pOutputfile)
	while 'inputstream.AtEnd {
	  set line = inputstream.ReadLine()
	    
	  set status = outputstream.WriteLine(line)
	  if $$$ISERR(status) { do $system.OBJ.DisplayError(status) Quit} 
	  
	}

	do outputstream.%Save()
	kill inputstream
	  
    quit status
}

ClassMethod SetupLocal(pDir As %String) As %Status [ PublicList = IO ]
{
  set status = $$$OK
    
  set namespace = $namespace
  set $namespace = "%SYS"

  set status=##Class(Config.Databases).Get("IRISLIB",.Properties)
  set db = ##class(SYS.Database).%OpenId(Properties("Directory"))
  set db.ReadOnly = 0
  set status = db.%Save()
    
  set os = $system.Version.GetOS()
  
  if os = "Windows" {
    set delim = "\"
  }
  else {
	set delim = "/"
  }
    	  
  do $System.OBJ.ImportDir(pDir_delim_"src"_delim_"core",,"ck",,1)
  do $System.OBJ.Load(pDir_delim_"src"_delim_"core"_delim_"dasl.gof")

  set $namespace = namespace
  
  do ^%DAINIT
  set IO = pDir_delim_"dsmdasl_demo-utf8.sav"
  do UTF8^%DALOAD
  
  set $namespace = "%SYS"

  set status=##Class(Config.Databases).Get("IRISLIB",.Properties)
  set db = ##class(SYS.Database).%OpenId(Properties("Directory"))
  set db.ReadOnly = 1
  set status = db.%Save()

  set $namespace = namespace

  quit status
}

}
