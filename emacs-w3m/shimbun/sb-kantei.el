;;; sb-kantei.el --- shimbun backend for kantei blog backnumber -*- coding: iso-2022-7bit; -*-

;; Copyright (C) 2001-2011 Yuuichi Teranishi <teranisi@gohome.org>

;; Author: Yuuichi Teranishi <teranisi@gohome.org>
;; Keywords: news

;; This file is a part of shimbun.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Code:

(require 'shimbun)

(luna-define-class shimbun-kantei (shimbun) ())

(defvar shimbun-kantei-url "http://www.kantei.go.jp/")

(defvar shimbun-kantei-groups '("blog-en"
				"blog-ja"
				"blog-en.kan"
				"blog-ja.kan"
				"m-magazine-cn.hatoyama"
				"m-magazine-kr.hatoyama"
				"m-magazine-en.hatoyama"
				"m-magazine-ja.hatoyama"
				"m-magazine-en.aso"
				"m-magazine-ja.aso"
				"m-magazine-en.fukuda"
				"m-magazine-ja.fukuda"
				"m-magazine-en.abe"
				"m-magazine-ja.abe"
				"m-magazine-en.koizumi"
				"m-magazine-ja.koizumi"
				;; Backward compatibility.
				"m-magazine")
  "List of the groups subscribing to the blog of Japan's Cabinet.
Old e-mail magazines' archive are also supported.
Note that the `m-magazine-ja.koizumi' is the same as `m-magazine'
which is for the backward compatibility.")

(defvar shimbun-kantei-x-face-alist
  ;; Don't change the order of the faces.  See the method function that
  ;; is applied to `shimbun-make-contents'.
  '(("default" . "X-Face: )y>~@`/54G8A3vhuan6E%su\\r]&ACV[`\"4|_2e\"!\
KcK5c8:G'\"C6<;7ovb1YWG4B%BY?:^r\n p[nt=j!$4c:Buz#]][;-i&P66^9aC<Hd>\
\\CtF^uD20*Y9SqW'lFN,mTLp[\"0`9Z?bS,BJ-CaA@a||]\n Oe]\";W)D3whpcUo(?a\
&S|i=u\"r>{N9/GRtw'OC2W9M%5t_>")
    ("\\.kan\\'" . "X-Face: #Mk`n~UfLBs/5u+Pl'tnaO~4.\";)nt-Ip-+H&X}D\
u!TN~u*]-#PJ(Xo'uKzpq-l]6pac=~T\n hm-vH$Bh88Kq<[!1tY7\\wVW{fV=9ad4!`|\
xnRw$tl:?a{01+wd:6ysB*[Mms:Gv%\\Dj-a<{MY{vKJK\n /*t91Ighysyc8}Z2NG#X]\
W9fUoRI<7zrQw")
    ("\\.hatoyama\\'" . "X-Face: Bhu:2dJ9#&[pX@hMRh=$pF|<M}p@,Fe{2SAS\
)tupW4jk^RavhwxRqDm>O>-,*d\"V+@u\"gB5\n ]}Yxh$n#S1BM<uz\\n|sXtBh\"1TH\
|g@:n,M4A7Cr8,MO$L-KmDmX&~)G+W:6gN0?c:5&o=JAJF6b7%_\n A{A`1-=;*q;RtW>\
o,8|XYsIrL4grl\\|6JV<A.,@%,RI\"v^EIY_[<>6fq3!B`28KP2,M/.Tsh")
    ("\\.aso\\'" . "X-Face: #(b'i|jCr9M1k*o`B1YbD.C*%\\T3~.mUK@q?}o4.\
TC*~*~fPaHg\\]V+Q2$3wu$=:[<k^Y<s\n X{VB1rZN[(X$(Cej@QV?FaoslWKi,fxp\"\
m\\<Cb#4vo!!hDZI@9I8gAMMp6>HZ'C/&9e15i*4e>OV4`\n pdAVvpz`w<$QCu9'~:}|\
h`SEZv\\U]f']V(QbE5'%u$InJltT4~|Ru\\vs~g!;y;1uY#8v<8|eGbb*i=\n a/RM<?\
`*?5`AL1#G(9F50D}`>Y:'\"^)0:;L!2x8j|br~q/E=j.s!FBI-6xr")
    ("\\.fukuda\\'" . "X-Face: R![ems6?kedF&(},`\";7nbUIT6Uyt2A9jSQ'\\\
$=;,n.9<lIS+DFBTdMEJ$nh0[t)XU!.D*p\n kd~cuh0/nvCm;1~B;Ib!g^TC*OHm5(<Z\
%=A2H_,kDt0E*HaI&^C%Wzb/EC_PF1f!jk7VHf=s*mqe91\n `H.J(Bq9(S'71?$O\\+=\
Kp\"yNww;MOGO&N+tm<MbYT}Mlh4<hahJgCV`P/<&9Fm|FRmb>vM+PFYQB}O\n <Se")
    ("\\.abe\\'" . "X-Face: 2lqMN=orK#d]Xl-K5P`=ApJHMB3[faCtca;G(i=qL\
^3qh<kEoLHF\"L\"x/a:|xD>x=IKEqN%\n 3EL93@D{*BW-{GE88b7{d^m-%v9}=-7=^M\
#$?zJm$]Yy07J^}:#V?9t_<{fhavZVZQ1^1=SLQf3X=<\n z|Af_njD},U!m}4V}$]L_7\
a!b>X!RW$['xZs$r=G?o|=M^O)IJoOurt|UKUu[UuQFT/r&vygySYUmf\n <G6B:zwx0@\
$xHbD#Hr3`J,C!5rN5t7oI)ng/'e40?>Jm;kjj")
    ("\\.koizumi\\'\\|\\`m-magazine\\'" . "X-Face: .bsmj'!8A`wI\\o+KF\
!)#0.a0,f1MA~PH/5T0fu$Mg+)_5G~NSk4.0t]&|f@^c3l8-Fuz8'|\n kr;td_Jn7|Gw\
REbDs'H9$Iy#yM#*J2c'L},(m8K:8?$vTPC%D}YJ[bV#7xw|{\"DJ:_?`V1m_4^+;7+\n\
 JOf6v&x6?mU-q=0}mTK5@\"-bFGuD}2Y/(lR/V#'?HRc2Jh2UrR,oIR~NL!})|^%kw")))

(luna-define-method shimbun-index-url ((shimbun shimbun-kantei))
  (let ((url
	 (let ((group (shimbun-current-group-internal shimbun)))
	   (cond ((string-equal group "blog-en")
		  "http://nodasblog.kantei.go.jp/archives.html")
		 ((string-equal group "blog-ja")
		  "http://kawaraban.kantei.go.jp/")
		 ((string-equal group "blog-en.kan")
		  "http://kansblog.kantei.go.jp/archives.html")
		 ((string-equal group "blog-ja.kan")
		  "http://kanfullblog.kantei.go.jp/archives.html")
		 ((string-equal group "m-magazine-cn.hatoyama")
		  "http://www.mmz.kantei.go.jp/\
foreign/m-magazine/backnumber_ch/hatoyama_index.html")
		 ((string-equal group "m-magazine-kr.hatoyama")
		  "http://www.mmz.kantei.go.jp/\
foreign/m-magazine/backnumber_ko/hatoyama_index.html")
		 ((string-equal group "m-magazine-en.hatoyama")
		  "http://www.mmz.kantei.go.jp/\
foreign/m-magazine/backnumber/hatoyama.html")
		 ((string-equal group "m-magazine-ja.hatoyama")
		  "http://www.mmz.kantei.go.jp/\
jp/m-magazine/backnumber/hatoyama.html")
		 ((string-equal group "m-magazine-en.aso")
		  "http://www.mmz.kantei.go.jp/\
foreign/m-magazine/backnumber/aso.html")
		 ((string-equal group "m-magazine-ja.aso")
		  "http://www.mmz.kantei.go.jp/\
jp/m-magazine/backnumber/aso.html")
		 ((string-equal group "m-magazine-en.fukuda")
		  "http://www.mmz.kantei.go.jp/\
foreign/m-magazine/backnumber/fukuda.html")
		 ((string-equal group "m-magazine-ja.fukuda")
		  "http://www.mmz.kantei.go.jp/\
jp/m-magazine/backnumber/hukuda.html")
		 ((string-equal group "m-magazine-en.abe")
		  "foreign/m-magazine/backnumber/abe.html")
		 ((string-equal group "m-magazine-ja.abe")
		  "jp/m-magazine/backnumber/abe.html")
		 ((string-equal group "m-magazine-en.koizumi")
		  "foreign/m-magazine/backnumber/koizumi.html")
		 ((string-equal group "m-magazine-ja.koizumi")
		  "jp/m-magazine/backnumber/koizumi.html")
		 ;; Backward compatibility.
		 ((string-equal group "m-magazine")
		  "jp/m-magazine/backnumber/koizumi.html")
		 ;; Default.
		 (t
		  "jp/m-magazine/backnumber/")))))
    (cond ((string-equal "http://kawaraban.kantei.go.jp/" url)
	   (concat url (format-time-string "%Y/%02m/")))
	  ((string-match "\\`http:" url)
	   url)
	  (t
	   (concat (shimbun-url-internal shimbun) url)))))

(luna-define-method shimbun-from-address ((shimbun shimbun-kantei))
  (let ((group (shimbun-current-group-internal shimbun)))
    (cond ((string-equal group "blog-en")
	   "Yoshihiko Noda")
	  ((string-equal group "blog-ja")
	   "$BLnED2BI'(B")
	  ((string-equal group "blog-en.kan")
	   "Naoto Kan")
	  ((string-equal group "blog-ja.kan")
	   "$B?{D>?M(B")
	  ((string-equal group "m-magazine-cn.hatoyama")
	   "$Ap/$B;3M3$A<M$BIW(B")
	  ((string-equal group "m-magazine-kr.hatoyama")
	   "$(CGOEd>_86(B $(C@/E0?@(B")
	  ((string-equal group "m-magazine-en.hatoyama")
	   "Yukio Hatoyama")
	  ((string-equal group "m-magazine-ja.hatoyama")
	   "$BH7;3M35*IW(B")
	  ((string-equal group "m-magazine-en.aso")
	   "Taro Aso")
	  ((string-equal group "m-magazine-ja.aso")
	   "$BKc@8B@O:(B")
	  ((string-equal group "m-magazine-en.fukuda")
	   "Yasuo Fukuda")
	  ((string-equal group "m-magazine-ja.fukuda")
	   "$BJ!ED9/IW(B")
	  ((string-equal group "m-magazine-en.abe")
	   "Shinzo Abe")
	  ((string-equal group "m-magazine-ja.abe")
	   "$B0BG\?8;0(B")
	  ((string-equal group "m-magazine-en.koizumi")
	   "Junichiro Koizumi")
	  ((string-equal group "m-magazine-ja.koizumi")
	   "$B>.@t=c0lO:(B")
	  ((string-equal group "m-magazine") ;; Backward compatibility.
	   "$B>.@t=c0lO:(B")
	  (t
	   "$BLnED2BI'(B"))))

(luna-define-method shimbun-get-headers ((shimbun shimbun-kantei)
					 &optional range)
  (let* ((group (shimbun-current-group-internal shimbun))
	 (blogp (string-match "\\`blog-" group))
	 (enp (string-match "\\`m-magazine-en" group))
	 (cnp (string-match "\\`m-magazine-cn" group))
	 (krp (string-match "\\`m-magazine-kr" group))
	 (regexp
	  (cond
	   (blogp
	    (eval-when-compile
	      (concat "<a[\t\n ]+href=\""
		      ;; 1. url
		      "\\(.+/"
		      ;; 2. year
		      "\\(20[1-9][0-9]\\)"
		      "/"
		      ;; 3. month
		      "\\([01]?[0-9]\\)"
		      "/\\(?:20\\)?[1-9][0-9][01][0-9]"
		      ;; 4. day of month
		      "\\([0-3][0-9]\\)"
		      ;; 5. revision e.g., 20110822-2.html
		      "\\(-[0-9]+\\)?"
		      "\\.html\\)"
		      "\"[^>]*>[\t\n ]*"
		      ;; 6. subject
		      "\\([^<]+\\)")))
	   (enp
	    (eval-when-compile
	      (concat "<A[\t\n ]+HREF=\""
		      ;; 1. url
		      "\\(\\(?:[a-z]+/\\)?"
		      ;; 2. year
		      "\\(20[0-9][0-9]\\)"
		      "/"
		      ;; 3. month
		      "\\([01][0-9]\\)"
		      ;; 4. day of month
		      "\\([0-3][0-9]\\)"
		      "\\.html\\)\"[^>]*>[\t\n ]*"
		      ;; 5. subject
		      "\\(\\(?:[^\t\n <]+[\t\n ]+\\)*[^\t\n <]+\\)"
		      "[\t\n ]*</A>[\t\n ]*</TD>[\t\n ]*</TR>")))
	   (cnp
	    (eval-when-compile
	      (concat "<a[\t\n ]+href=\""
		      ;; 1. url
		      "\\(\\(?:/foreign/m-magazine/backnumber_ch/\\)?"
		      ;; 2. year
		      "\\(20[0-9][0-9]\\)"
		      "/"
		      ;; 3. month
		      "\\([01][0-9]\\)"
		      ;; 4. day of month
		      "\\([0-3][0-9]\\)"
		      "\\.html\\)\"[^>]*>[\t\n ]*"
		      ;; 5. subject
		      "\\(\\(?:[^\t\n <]+[\t\n ]+\\)*[^\t\n <]+\\)"
		      "[\t\n ]*</a>[\t\n ]*</td>[\t\n ]*</tr>")))
	   (krp
	    (eval-when-compile
	      (concat "<a[\t\n ]+href=\""
		      ;; 1. url
		      "\\(\\(?:/foreign/m-magazine/backnumber_ko/\\)?"
		      ;; 2. year
		      "\\(20[0-9][0-9]\\)"
		      "/"
		      ;; 3. month
		      "\\([01][0-9]\\)"
		      ;; 4. day of month
		      "\\([0-3][0-9]\\)"
		      "\\.html\\)\"[^>]*>[\t\n ]*"
		      ;; 5. subject
		      "\\(\\(?:[^\t\n <]+[\t\n ]+\\)*[^\t\n <]+\\)"
		      "[\t\n ]*</a>[\t\n ]*</td>[\t\n ]*</tr>")))
	   (t
	    (eval-when-compile
	      (concat "<A[\t\n ]+HREF=\""
		      ;; 1. url
		      "\\(\\(?:/jp/m-magazine/backnumber/\\)?"
		      ;; 2. year
		      "\\(20[0-9][0-9]\\)"
		      "/"
		      ;; 3. month
		      "\\([01][0-9]\\)"
		      ;; 4. day of month
		      "\\([0-3][0-9]\\)"
		      ;; 5. revision e.g., 2005/0602b.html
		      "\\([^.]+\\)?"
		      "\\.html\\)"
		      "\"[^>]*>[\t\n ]*$B!Z(B[^$B![(B]+$B![(B[\t\n ]*"
		      ;; 6. subject
		      "\\([^<]+\\)")))))
	 (parent (shimbun-index-url shimbun))
	 (murl parent)
	 (from (shimbun-from-address shimbun))
	 year month mday url subject id headers)
    (catch 'stop
      (while t
	;; Remove commented areas.
	(while (re-search-forward "<!-+" nil t)
	  (when (shimbun-end-of-tag nil t)
	    (replace-match "\n")))
	(goto-char (point-min))
	(while (re-search-forward regexp nil t)
	  (if (or enp cnp krp)
	      (setq year (string-to-number (match-string 2))
		    month (string-to-number (match-string 3))
		    mday (string-to-number (match-string 4))
		    url (match-string 1)
		    subject (match-string 5)
		    id (format "<%d%02d%02d.%s%%kantei.go.jp>"
			       year month mday group))
	    (setq year (string-to-number (match-string 2))
		  month (string-to-number (match-string 3))
		  mday (string-to-number (match-string 4))
		  url (match-string 1)
		  subject (shimbun-replace-in-string (match-string 6)
						     "[\t\n $B!!(B]+" " ")
		  id (format "<%d%02d%02d%s.%s%%kantei.go.jp>"
			     year month mday
			     (or (match-string 5) "")
			     group)))
	  (when (and (string-equal group "blog-ja")
		     (shimbun-search-id shimbun id))
	    (throw 'stop nil))
	  (push (shimbun-create-header
		 0 subject from
		 (shimbun-make-date-string year month mday)
		 id "" 0 0
		 (if (string-match "\\`http:" url)
		     url
		   (shimbun-expand-url url parent)))
		headers))
	(if (string-equal group "blog-ja")
	    (if (string-match "/\\(20[1-9][0-9]\\)/\\([01][0-9]\\)/\\'" murl)
		(progn
		  (setq year (string-to-number (match-string 1 murl))
			month (1- (string-to-number (match-string 2 murl))))
		  (when (<= month 0)
		    (setq month 12
			  year (1- year)))
		  (if (and (= year 2011) (< month 9))
		      (throw 'stop nil)
		    (setq murl (format "%s/%d/%02d/"
				       (substring murl 0 (match-beginning 0))
				       year month))
		    (erase-buffer)
		    (shimbun-retrieve-url murl)))
	      (throw 'stop nil))
	  (throw 'stop nil))))
    (shimbun-sort-headers headers)))

(luna-define-method shimbun-clear-contents :around ((shimbun shimbun-kantei)
						    header)
  (let ((case-fold-search t)
	start end section)
    (if (and (search-forward "<pre>" nil t)
	     (progn
	       (setq start (match-beginning 0))
	       (goto-char (point-max))
	       (search-backward "</pre>" nil t)))
	(progn
	  (delete-region (match-end 0) (point-max))
	  (insert "\n")
	  (delete-region (point-min) start)
	  t)
      (if (re-search-forward "<!-+[\t\n ]*content[\t\n ]*-+>[\t\n ]*\
\\(?:<[^>]+>[\t\n ]*\\)*"
			     nil t)
	  (progn
	    (setq start (match-end 0))
	    (re-search-forward "\\(?:[\t\n ]*<[^>]+>\\)*[\t\n ]*\
\\(?:<a[\t\n ]+href=\"#[^>]+>[\t\n ]*\
go[\t\n ]+to[\t\n ]+top[\t\n ]+of[\t\n ]+the[\t\n ]+page[\t\n ]*</a>\
\\|<a[\t\n ]*href=\"[^>]+>[\t\n ]*subscription[\t\n ]*</a>\
\\|<!-+[\t\n ]*/content[\t\n ]*-+>\\)"
			       nil t)
	    (delete-region (match-beginning 0) (point-max))
	    (insert "\n")
	    (delete-region (point-min) start)))
      (goto-char (point-min))
      (if (and (re-search-forward "<!--\\(\\cj+\\)-->[\t\n ]*" nil t)
	       (progn
		 (setq section (regexp-quote (match-string 1))
		       start (match-end 0))
		 (re-search-forward (concat "\[\t\n ]*<!--/" section
					    "\\(?:$B$+$i(B\\)?-->")
				    nil t)))
	  (progn
	    (setq end (match-beginning 0))
	    (while (when (re-search-forward "<!--\\(\\cj+\\)-->[\t\n ]*" nil t)
		     (setq section (regexp-quote (match-string 1)))
		     (delete-region end (match-end 0))
		     (insert "\n&#012;\n")
		     (and (re-search-forward (concat "\[\t\n ]*<!--/" section
						     "\\(?:$B$+$i(B\\)?-->")
					     nil t)
			  (setq end (match-beginning 0)))))
	    (if (and (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*align=\"center\"" nil t)
		     (shimbun-end-of-tag "div" t))
		(progn
		  (delete-region (match-end 1) (point-max))
		  (insert "\n")
		  (goto-char end)
		  (delete-region end (match-beginning 3))
		  (insert "\n<div align=\"left\">\n--&nbsp;<br>\n"))
	      (delete-region end (point-max))
	      (insert "\n"))
	    (delete-region (point-min) start))
	;; Remove style sheet.
	(shimbun-remove-tags "style" t)
	;; Remove navigation button.
	(shimbun-remove-tags "\\(td\\|span\\)\
\\(?:[\t\n ]+[^\t\n >]+\\)*[\t\n ]+class=\"breadcrumbs\"" t))
      ;; Remove useless tags.
      (goto-char (point-min))
      (while (re-search-forward "[\t\n ]*</tr>[\t\n ]*" nil t)
	(replace-match "<br>\n"))
      (goto-char (point-min))
      (while (re-search-forward "\
\[\t\n ]*</?\\(?:hr\\|span\\|table\\|td\\|tr\\)\\(?:[\t\n ]+[^>]+\\)?>[\t\n ]*"
				nil t)
	(replace-match "\n"))
      (goto-char (point-min))
      (while (re-search-forward "[\t\n ]*<p[\t\n ]+[^>]+>[\t\n ]*" nil t)
	(replace-match "\n<p>"))
      (goto-char (point-min))
      (while (re-search-forward "[\t\n ]*<![^>]+>[\t\n ]*" nil t)
	(replace-match "\n"))
      (goto-char (point-min))
      (while (re-search-forward "^[\t $B!!(B]+\n" nil t)
	(delete-region (match-beginning 0) (match-end 0)))
      (goto-char (point-min))
      (while (re-search-forward "\\([\t\n ]*<br\\(?:[\t\n ]+[^>]*\\)?>\\)\
\\(?:[\t\n ]*<br\\(?:[\t\n ]+[^>]*\\)?>\\)+[\t\n ]*\\(<br[\t\n >]\\)" nil t)
	(replace-match "\\1\\2"))
      (goto-char (point-min))
      (skip-chars-forward "\t\n ")
      (delete-region (point-min) (point))
      (while (re-search-forward "[\t\n ]+\n" nil t)
	(replace-match "\n"))
      ;; Insert newlines around images.
      (goto-char (point-min))
      (while (re-search-forward "[\t\n ]*\\(\\(?:<[^/][>]+>[\t\n ]*\\)*\
<img[\t\n ]+[^>]+>\\(?:[\t\n ]*<[^/][>]+>\\)*\\)[\t\n ]*" nil t)
	(replace-match "<br>\n\\1<br>\n"))
      ;; Shrink boundary lines.
      (let ((limit (w3m-static-if (featurep 'xemacs)
		       (when (device-on-window-system-p)
			 (font-width (face-font 'default)))
		     (when window-system
		       (frame-char-width)))))
	(when limit
	  (setq limit (* limit (1- (window-width))))
	  (goto-char (point-min))
	  (while (re-search-forward
		  "<img\\(?:[\t\n ]+[^\t\n >]+\\)*[\t\n ]+height=\"1\""
		  nil t)
	    (when (shimbun-end-of-tag)
	      (goto-char (match-beginning 0))
	      (if (re-search-forward "width=\"\\([0-9]+\\)\"" (match-end 0) t)
		  (when (> (string-to-number (match-string 1)) limit)
		    (replace-match (concat "width=\"" (number-to-string limit)
					   "\"")))
		(goto-char (match-end 0)))))))
      (cond ((string-equal "blog-ja" (shimbun-current-group-internal shimbun))
	     (goto-char (point-min))
	     (when (and (or (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"block article\"" nil t)
			    (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"block header\"" nil t))
			(shimbun-end-of-tag "div"))
	       (goto-char (setq start (match-beginning 2)))
	       (when (re-search-forward "[\t\n ]*\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"footer\"" nil t)
		 (delete-region (match-beginning 0) (point-max))
		 (insert "\n")
		 (delete-region (point-min) start))))
	    ((string-match "\\`blog-" (shimbun-current-group-internal shimbun))
	     (goto-char (point-min))
	     (when (and (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"entry-body\"" nil t)
			(shimbun-end-of-tag "div" t))
	       (delete-region (match-end 2) (point-max))
	       (insert "\n")
	       (delete-region (point-min) (match-beginning 2))
	       (goto-char (point-min))
	       (while (re-search-forward "\
\[\t\n $B!!(B]*<p>\\(?:[\t\n $B!!(B]*\\|[\t\n ]*&nbsp;[\t\n ]*\\)</p>[\t\n $B!!(B]*"
					 nil t)
		 (replace-match "")))))
      ;; Zenkaku ASCII -> Hankaku
      (unless (memq (shimbun-japanese-hankaku shimbun) '(header subject nil))
	(shimbun-japanese-hankaku-buffer t)))))

(luna-define-method shimbun-make-contents :around ((shimbun shimbun-kantei)
						   header)
  (if (string-match "\\`m-magazine-\\(?:cn\\|en\\|ja\\|kr\\)\\'"
		    (shimbun-current-group-internal shimbun))
      ;; Choose a face according to the author.
      (let ((shimbun-x-face-database-function
	     (or shimbun-x-face-database-function
		 (let ((from (shimbun-header-from header t)))
		   `(lambda (ignore)
		      ,(cdr (nth
			     (cond ((member from '("Naoto Kan"
						   "$B?{D>?M(B"))
				    1)
				   ((member from '("Yukio Hatoyama"
						   "$BH7;3M35*IW(B"
						   "$Ap/$B;3M3$A<M$BIW(B"
						   "$(CGOEd>_86(B $(C@/E0?@(B"))
				    2)
				   ((member from '("Taro Aso"
						   "$BKc@8B@O:(B"))
				    3)
				   ((member from '("Yasuo Fukuda"
						   "$BJ!ED9/IW(B"))
				    4)
				   ((member from '("Shinzo Abe"
						   "$B0BG\?8;0(B"))
				    5)
				   ((member from '("Junichiro Koizumi"
						   "$B>.@t=c0lO:(B"))
				    6)
				   (t
				    0))
			     shimbun-kantei-x-face-alist)))))))
	(luna-call-next-method))
    (luna-call-next-method)))

(provide 'sb-kantei)

;;; sb-kantei.el ends here
