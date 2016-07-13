# Gesturing
A prototype iOS handwriting recognition engine.  I wrote this in 2008 as a potential input method for a Sudoku game I was building.  While I never used it in production I did get it to a reasonable level of accuracy.  

The way it works is by taking an input gesture (supports only single gestures, not multi at this point), normalizing it to a fixed # of ordered vectors.  That ordered set of vectors is then compared against all known gestures for digits in the alphabet (0-9).  The best match (least angle differential) wins.

Overall this is *very naive* yet works well for numerals 0-9.  4 requires multiple gestures but still works on the first match assuming you draw it the way I do (start at top, move SW, then E).  

## CVPathNormalizer / CVPathWalker
Given an input gesture (single path) converts it to normalized path of n segments.  This is important as the # of segments it's normalized to must match the # of segments our character database uses.  These two classes together do the work.

## CVPatternDelta
Given a path compares it to the alphabet database and returns an array of best matches in descending order.  The firstmost match is your best match. 
