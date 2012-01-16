<?php 
	require_once("scheme.php");

	$name = ($_GET['values']);
//	$package = json_decode($_POST['package']);
	$magic = explode(",", $name);
	$fileName = $magic[13];
	if (strlen($fileName) == 0)
		$fileName = "generic";
	$scopes = array();
	if ( intval($magic[14]) > 49)
		$scheme = "set background=light\n";
	else
		$scheme = "set background=dark\n";
	$scheme = $scheme."highlight clear\n".
	"if exists(\"syntax on\")\n".
	"\tsyntax reset\n".
	"endif\n".
	"let g:colors_name=\"".$fileName."\"\n";

	$scopes [] = new vimnode("Normal", "NONE", "$magic[1]", "$magic[0]");
	$scopes [] = new vimnode("Comment", "NONE", "$magic[2]", "NONE");
	$scopes [] = new vimnode("Constant", "NONE", "$magic[3]", "NONE");
	$scopes [] = new vimnode("String", "NONE", "$magic[4]", "NONE");
	$scopes [] = new vimnode("htmlTagName", "NONE", "$magic[5]", "NONE");
	$scopes [] = new vimnode("Identifier", "NONE", "$magic[6]", "NONE");
	$scopes [] = new vimnode("Statement", "NONE", "$magic[7]", "NONE");
	$scopes [] = new vimnode("PreProc", "NONE", "$magic[8]", "NONE");
	$scopes [] = new vimnode("Type", "NONE", "$magic[9]", "NONE");
	$scopes [] = new vimnode("Function", "NONE", "$magic[10]", "NONE");
	$scopes [] = new vimnode("Repeat", "NONE", "$magic[11]", "NONE");
	$scopes [] = new vimnode("Operator", "NONE", "$magic[12]", "NONE");

	foreach ($scopes as $line) {
		$highlight = "hi ".$line->getScope().
		//" gui=".$line->getGui().
			" guifg=".$line->getfg().
			" guibg=".$line->getbg();
		$scheme = $scheme.$highlight."\n";
	}

	$scheme = $scheme.
	//"hi Ignore guifg=".scopes[0]->getbg()."\n".
	"hi Error guibg=#ff0000 guifg=#ffffff\n".
	"hi TODO guibg=#0011ff guifg=#ffffff\n".
	"hi link character	constant\n".
	"hi link number	constant\n".
	"hi link boolean	constant\n".
	"hi link Float		Number\n".
	"hi link Conditional	Repeat\n".
	"hi link Label		Statement\n".
	"hi link Keyword	Statement\n".
	"hi link Exception	Statement\n".
	"hi link Include	PreProc\n".
	"hi link Define	PreProc\n".
	"hi link Macro		PreProc\n".
	"hi link PreCondit	PreProc\n".
	"hi link StorageClass	Type\n".
	"hi link Structure	Type\n".
	"hi link Typedef	Type\n".
	"hi link htmlTag	Special\n".
	"hi link Tag		Special\n".
	"hi link SpecialChar	Special\n".
	"hi link Delimiter	Special\n".
	"hi link SpecialComment Special\n".
	"hi link Debug		Special";


	// Define the path to file
	// header("Content-Disposition: attachment; filename=$fileName.\".vim\"");
	//header ("Content-Type: application/octet-stream");
	$file = $scheme;
	header("Content-Description: File Transfer");
	header ("Content-Disposition: attachment; filename=$fileName.vim");
	echo $file;
?>
