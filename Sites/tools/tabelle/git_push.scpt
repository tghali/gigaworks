FasdUAS 1.101.10   ��   ��    l    @ ����  O     @    k    ?     	  r     
  
 c        l    ����  n        m   	 ��
�� 
ctnr  l   	 ����  I   	�� ��
�� .earsffdralis        afdr   f    ��  ��  ��  ��  ��    m    ��
�� 
ctxt  o      ���� 0 mypath myPath 	     r        n        1    ��
�� 
psxp  o    ���� 0 mypath myPath  o      ���� 0 myfolderpath myFolderPath      l   ��  ��    ! display dialog myFolderPath     �   6 d i s p l a y   d i a l o g   m y F o l d e r P a t h      l   ��   !��     : 4do shell script "cd " & myFolderPath & ";git status"    ! � " " h d o   s h e l l   s c r i p t   " c d   "   &   m y F o l d e r P a t h   &   " ; g i t   s t a t u s "   # $ # r     % & % c     ' ( ' m     ) ) � * *  ; g i t   c o m m i t   - a ( m    ��
�� 
ctxt & o      ���� 
0 befehl   $  + , + r    ' - . - n    % / 0 / 1   # %��
�� 
pnam 0 n    # 1 2 1 m   ! #��
�� 
ctnr 2 l   ! 3���� 3 I   !�� 4��
�� .earsffdralis        afdr 4  f    ��  ��  ��   . o      ���� 0 
ordnername   ,  5 6 5 l  ( (�� 7 8��   7  display dialog ordnername    8 � 9 9 2 d i s p l a y   d i a l o g   o r d n e r n a m e 6  : ; : l  ( (��������  ��  ��   ;  < = < l  ( (�� > ?��   > C =git push "git@github.com:ruediheimlicher/Tabelle.git" master	    ? � @ @ z g i t   p u s h   " g i t @ g i t h u b . c o m : r u e d i h e i m l i c h e r / T a b e l l e . g i t "   m a s t e r 	 =  A B A l  ( (�� C D��   C F @set gitadresse to "git@github.com:ruediheimlicher/" & ordnername    D � E E � s e t   g i t a d r e s s e   t o   " g i t @ g i t h u b . c o m : r u e d i h e i m l i c h e r / "   &   o r d n e r n a m e B  F G F r   ( + H I H m   ( ) J J � K K T g i t @ g i t h u b . c o m : r u e d i h e i m l i c h e r / T a b e l l e . g i t I o      ���� 0 
gitadresse   G  L M L l  , ,�� N O��   N 0 *display dialog "gitadresse: " & gitadresse    O � P P T d i s p l a y   d i a l o g   " g i t a d r e s s e :   "   &   g i t a d r e s s e M  Q R Q I  , =�� S��
�� .sysoexecTEXT���     TEXT S b   , 9 T U T b   , 5 V W V b   , 1 X Y X b   , / Z [ Z m   , - \ \ � ] ]  c d   " [ o   - .���� 0 myfolderpath myFolderPath Y m   / 0 ^ ^ � _ _  / " ;   g i t   p u s h   W n   1 4 ` a ` 1   2 4��
�� 
strq a o   1 2���� 0 
gitadresse   U m   5 8 b b � c c    m a s t e r��   R  d�� d l  > >��������  ��  ��  ��    m      e e�                                                                                  MACS  alis    t  Macintosh HD               ���H+   9%�
Finder.app                                                      9�Y�[��        ����  	                CoreServices    �}�      �[ja     9%� 9%� 9%�  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��       �� f g��   f ��
�� .aevtoappnull  �   � **** g �� h���� i j��
�� .aevtoappnull  �   � **** h k     @ k k  ����  ��  ��   i   j  e������������ )������ J�� \ ^�� b��
�� .earsffdralis        afdr
�� 
ctnr
�� 
ctxt�� 0 mypath myPath
�� 
psxp�� 0 myfolderpath myFolderPath�� 
0 befehl  
�� 
pnam�� 0 
ordnername  �� 0 
gitadresse  
�� 
strq
�� .sysoexecTEXT���     TEXT�� A� =)j �,�&E�O��,E�O��&E�O)j �,�,E�O�E�O��%�%��,%a %j OPUascr  ��ޭ