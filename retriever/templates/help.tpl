<h2>Retriever Plugin Help</h2>
<p>
This plugin replaces the short excerpts you normally get in RSS feeds
with the full content of the article from the source website.  You
specify which part of the page you're interested in with a set of
rules.  When each item arrives, the plugin downloads the full page
from the website, extracts content using the rules, and replaces the
original article.
</p>
<p>
There's a few reasons you may want to do this.  The source website
might be slow or overloaded.  The source website might be
untrustworthy, in which case using Friendica to scrub the HTML is a
good idea.  You might be on a LAN that blacklists certain websites.
It also works neatly with the mailstream plugin, allowing you to read
a news stream comfortably without needing continuous Internet
connectivity.
</p>
<p>
However, setting up retriever can be quite tricky since it depends on
the internal design of the website.  That was designed to make life
easy for the website's developers, not for you.  You'll need to have
some familiarity with HTML, and be willing to adapt when the website
suddenly changes everything without notice.
</p>
<h3>Configuring Retriever for a feed</h3>
<p>
To set up retriever for an RSS feed, go to the "Contacts" page and
find your feed.  Then click on the drop-down menu on the contact.
Select "Retriever" to get to the retriever configuration.
</p>
<p>
The "Include" configuration section specifies parts of the page to
include in the article.  Each row has three components:
</p>
<ul>
<li>An HTML tag (e.g. "div", "span", "p")</li>
<li>An attribute (usually "class" or "id")</li>
<li>A value for the attribute</li>
</ul>
<p>
A simple case is when the article is wrapped in a "div" element:
</p>
<pre>
    ...
    &lt;div class="ArticleWrapper"&gt;
      &lt;h2&gt;Man Bites Dog&lt;/h2&gt;
      &lt;img src="mbd.jpg"&gt;
      &lt;p&gt;
        Residents of the sleepy community of Nowheresville were
        shocked yesterday by the sight of creepy local weirdo Jim
        McOddman assaulting innocent local dog Snufflekins with his
        false teeth.
      &lt;/p&gt;
      ...
    &lt;/div&gt;
    ...
</pre>
<p>
You then specify the tag "div", attribute "class", and value
"ArticleWrapper".  Everything else in the page, such as navigation
panels and menus and footers and so on, will be discarded.  If there
is more than one section of the page you want to include, specify each
one on a separate row.  If the matching section contains some sections
you want to remove, specify those in the "Exclude" section in the same
way.
</p>
<p>
Once you've got a configuration that you think will work, you can try
it out on some existing articles.  Type a number into the
"Retrospectively Apply" box and click "Submit".  After a while
(exactly how long depends on your system's cron configuration) the new
articles should be available.
</p>
<h3>Techniques</h3>
<p>
You can leave the attribute and value blank to include all the
corresponding elements with the specified tag name.  You can also use
a tag name of just an asterisk ("*"), which will match any element type with the
specified attribute regardless of the tag.
</p>
<p>
Note that the "class" attribute is a special case.  Many web page
templates will put multiple different classes in the same element,
separated by spaces.  If you specify an attribute of "class" it will
match an element if any of its classes matches the specified value.
For example:
</p>
<pre>
    &lt;div class="article breaking-news"&gt;
</pre>
<p>
In this case you can specify a value of "article", or "breaking-news".
You can also specify "article breaking-news", but that won't match if
the website suddenly changes to "breaking-news article", so that's not
recommended.
</p>
<p>
One useful trick you can try is using the website's "print" pages.
Many news sites have print versions of all their articles.  These are
usually drastically simplified compared to the live website page.
Sometimes this is a good way to get the whole article when it's
normally split across multiple pages.
</p>
<p>
Hopefully the URL for the print page is a predictable variant of the
normal article URL.  For example, an article URL like:
</p>
<pre>
    http://www.newssite.com/article-8636.html
</pre>
<p>
...might have a print version at:
</p>
<pre>
    http://www.newssite.com/print/article-8636.html
</pre>
<p>
To change the URL used to retrieve the page, use the "URL Pattern" and
"URL Replace" fields.  The pattern is a regular expression matching
part of the URL to replace.  In this case, you might use a pattern of
"/article" and a replace string of "/print/article".  A common pattern
is simply a dollar sign ("$"), used to add the replace string to the end of the URL.
</p>
<h3>Background Processing</h3>
<p>
Note that retrieving and processing the articles can take some time,
so it's done in the background.  Incoming articles will be marked as
invisible while they're in the process of being downloaded.  If a URL
fails, the plugin will keep trying at progressively longer intervals
for up to a month, in case the website is temporarily overloaded or
the network is down.
</p>
<h3>Retrieving Images</h3>
<p>
Retriever can also optionally download images and store them in the
local Friendica instance.  Just check the "Download Images" box.  You
can also download images in every item from your network, whether it's
an RSS feed or not.  Go to the "Settings" page and
click <a href="$config">"Plugin settings"</a>.  Then check the "All
Photos" box in the "Retriever Settings" section and click "Submit".
</p>
<h2>Configure Feeds:</h2>
<div>
{{foreach $feeds as $feed}}
{{include file='contact_template.tpl' contact=$feed}}
{{/foreach}}
</div>
