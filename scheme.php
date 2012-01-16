<?php
	class vimnode
	{
		var $scope;
		var $gui;
		var $guifg;
		var $guibg;

		function __construct($target, $style, $fgcolor, $bgcolor){
			$this->scope = $target;
			$this->gui = $style;
			$this->guifg=$fgcolor;
			$this->guibg=$bgcolor;
		}

		public function getScope(){
			return $this->scope;
		}

		public function getGui(){
			return $this->gui;
		}

		public function getfg(){
			return $this->guifg;
		}

		public function getbg(){
			return $this->guibg;
		}
	}
?>
