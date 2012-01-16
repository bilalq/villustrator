<!DOCTYPE HTML>
<html>
<head>
	<?php require_once("scheme.php"); ?>
	<script type="text/javascript" src="../jquery.js"></script>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="style.css" />
	<title>Villustrator</title>
	<script type="text/javascript">
		
	</script>
</head>
<body>
	<div id="wrapper">
		<h1>Villustrator</h1>
		<?php
			$fileName = "generic";
			$scopes = array();
			$scheme = "set background=dark\n";
			$scheme = $scheme."highlight clear\n".
							"if exists(\"syntax on\")\n".
							"\tsyntax reset\n".
							"endif\n".
							"let g:colors_name=\"".$fileName."\"\n";

			$test = new vimnode("String", "NONE", "#000000", "#ffffff");
			
			$scopes []= $test;
			foreach ($scopes as $line) {
				$highlight = "hi ".$line->getScope().
							" gui=".$line->getGui().
							" guifg=".$line->getfg().
							" guibg=".$line->getbg();
				$scheme = $scheme.$highlight."\n";
			}

			$scheme = $scheme.
				"hi Ignore guifg=".scopes[0]->getbg()."\n".
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
				"hi link Tag		Special\n".
				"hi link SpecialChar	Special\n".
				"hi link Delimiter	Special\n".
				"hi link SpecialComment Special\n".
				"hi link Debug		Special";
			echo "\n".$scheme."\n";
		?>
	</div>
</body>
</html>
