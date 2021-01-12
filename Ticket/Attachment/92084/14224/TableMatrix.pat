Index: develop/TableMatrix/TableMatrix/SpreadsheetHideRows.pm
diff -c develop/TableMatrix/TableMatrix/SpreadsheetHideRows.pm:1.4 develop/TableMatrix/TableMatrix/SpreadsheetHideRows.pm:1.5
*** develop/TableMatrix/TableMatrix/SpreadsheetHideRows.pm:1.4	Fri Dec  6 08:08:21 2002
--- develop/TableMatrix/TableMatrix/SpreadsheetHideRows.pm	Fri Dec  5 16:24:56 2003
***************
*** 349,355 ****
  		foreach my $rowNum (sort {$a<=>$b} keys %$convertedSubData){
  			$subLevelIndex = "$rowNum,$selectorCol";
  			if( $indRowCols->{$subLevelIndex} eq '-'){
! 				$lowerLevelHideRows += $self->hideDetail($rowNum,$convertedSubData);
  			}
  		}
  	}
--- 349,357 ----
  		foreach my $rowNum (sort {$a<=>$b} keys %$convertedSubData){
  			$subLevelIndex = "$rowNum,$selectorCol";
  			if( $indRowCols->{$subLevelIndex} eq '-'){
! 				# For lower-level hide-detail calls, we don't use any updates to the
! 				#   expandData Arg, so we create an anonymous hash ref in this call
! 				$lowerLevelHideRows += $self->hideDetail($rowNum,{ %$convertedSubData} );
  			}
  		}
  	}
