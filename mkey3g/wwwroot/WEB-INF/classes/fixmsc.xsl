<?xml version="1.0"?>
<!-- 
* 自动转换MSC2为MSC3
* 日期：2009-07-16
* by yesun
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <!--解析MSC2标签 Start-->

  <!--msc节点-->
  <xsl:template match="msc">
    <!--解析标准msc-->
    <xsl:choose>
      <xsl:when test="@type = 'grid' or @type = 'list' or @type = 'form'">
        <msc type="form" action="{@action}">
            <xsl:if test="@type = 'grid' or @type = 'list' or @islogin = 'true'">
              <xsl:attribute name="islogin">true</xsl:attribute>
            </xsl:if>
          <head>
            <title>
              <xsl:value-of select="@title"/>
            </title>
          </head>
          <body>
            <xsl:if test="@background!=''">
              <xsl:attribute name="background">
                <xsl:value-of select="@background"/>
              </xsl:attribute>
            </xsl:if>

            <xsl:if test="@fullbody = 'true'">
              <xsl:attribute name="fullbody">true</xsl:attribute>
            </xsl:if>
            
              <!-- by wzc 处理Userdefined -->
			  <xsl:if test="//userdefined">
			  	<xsl:apply-templates select="//userdefined" mode="userdefined" />
			  </xsl:if>
            
            <!--处理MSC2的object[@type = 'navigation']-->
            <xsl:if test="//head/object[@type = 'navigation']/select">
              <span width="100%" bgcolor="#999999">
                <xsl:apply-templates select="//head/object[@type = 'navigation']/select" mode="navigation" />
              </span>
            </xsl:if>
            
            <!--grid-->
            <xsl:if test="@type = 'grid'">
              <grid mode="3">
                <xsl:if test="@row">
                  <xsl:attribute name="mode">
                    <xsl:value-of select="@row"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="//item" mode="grid"/>
              </grid>
            </xsl:if>

            <!--list-->
            <xsl:if test="@type = 'list'">
              <listbox>
                <xsl:apply-templates select="//item" mode="list"/>
              </listbox>
            </xsl:if>

            <xsl:if test="@type = 'form'">
              <xsl:choose>
                <xsl:when test="//body">
                  <xsl:apply-templates select="//body" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>

            <!--状态栏文字-->
            <xsl:if test="@statusbar_caption">
              <span width="100%" dock="bottom" bgcolor="#999999">
                <xsl:value-of select="@statusbar_caption"/>
              </span>
            </xsl:if>
          </body>
          <xsl:apply-templates select="//foot|//head/object[@type='toolbar']" mode="foot"/>
        </msc>
      </xsl:when>
      <xsl:when test="@type = 'servermsg' or @type = 'returnmsg'">
        <msc type="servermsg" priority="high">
          <xsl:if test="@islogin = 'true'">
            <xsl:attribute name="islogin">true</xsl:attribute>
          </xsl:if>
          <xsl:if test="msg">
            <xsl:apply-templates select="//msg[1]"  mode="servermsg"/>
          </xsl:if>
        </msc>
      </xsl:when>
      <!-- 添加imageview -->
      <xsl:when test="@type = 'imageview'">
      	<msc type="imageview" >
      		<xsl:apply-templates select="//item" mode="imageview"/>
      	</msc>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- imageview::item -->
  <xsl:template match="item" mode="imageview"> 
  	<image src="{@src}"/>
  </xsl:template>

  <!--grid::item节点-->
  <xsl:template match="item" mode="grid">
    <item target="_self" caption="{@caption}" icon="{@icon}" href="{@href}">
      <xsl:if test="@target">
        <xsl:attribute name="target">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
      </xsl:if>
    </item>
  </xsl:template>

  <!--list::item节点-->
  <xsl:template match="item" mode="list">
    <listitem target="_self" href="{@href}">
      <xsl:if test="@target">
        <xsl:attribute name="target">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@icon">
        <xsl:attribute name="icon">
          <xsl:value-of select="@icon"/>
        </xsl:attribute>
      </xsl:if>
      
      <caption>
        <xsl:value-of select="@caption"/>
      </caption>

      <xsl:if test="@sndcaption != ''">
        <sndcaption>
          <xsl:value-of select="@sndcaption"/>
        </sndcaption>
      </xsl:if>
    </listitem>
  </xsl:template>

  <!--解析fileset和-->
  <xsl:template match="fileset">
    <fileset>
      <xsl:if test="@name">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:if test="@eu = 'false' ">
        <xsl:attribute name="enableadd">false</xsl:attribute>
      </xsl:if>
      <!--修改fileset節點下的属性，去掉enableadd、enabledel的显示 二者默认为true-->
      <xsl:if test="@eu = 'true' or not(@eu)">
      </xsl:if>
	  <xsl:if test="@ed = 'true'  or not(@ed)">  
      </xsl:if>
      <xsl:if test="@ed = 'false'">
        <xsl:attribute name="enabledel">false</xsl:attribute>
      </xsl:if>
      
      <xsl:apply-templates select="item" mode="fileset" />
    </fileset>
  </xsl:template>

  <xsl:template match="treenode">
  </xsl:template>

  <!--解析foot和object[@type='toolbar']-->
  <xsl:template match="foot|object" mode="foot">
    <foot>
      <xsl:apply-templates select="input" mode="foot" />
    </foot>
  </xsl:template>

  <!--解析foot::input-->
  <xsl:template match="input" mode="foot">
    <item caption="{@caption}" type="{@type}">
      <xsl:if test="@name">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@value">
        <xsl:attribute name="value">
          <xsl:value-of select="@value"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@href">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@target">
        <xsl:attribute name="target">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@align = 'primary'">
        <xsl:attribute name="align">primary</xsl:attribute>
      </xsl:if>
    </item>
  </xsl:template>
  
  <!--解析userdefined 重复
  <xsl:template match="userdefined">
  	<xsl:copy />
  </xsl:template>
	-->
  <!--解析body-->
  <xsl:template match="body">
    <xsl:apply-templates />
  </xsl:template>

  <!--解析head-->
  <xsl:template match="head">
  </xsl:template>

  <!--解析object(multiselect|date_time|date|time|navigation)-->
  <xsl:template match="object">
    <xsl:choose>
      <xsl:when test="@type='multiselect' and (@style = 'tree' or (@style = 'formtree' and (//body/@fullbody = 'false' or not (//body/@fullbody))))">
        <combotree>
          <xsl:if test="@name">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@caption">
            <xsl:attribute name="caption">
              <xsl:value-of select="@caption"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@writeable = 'true'">
            <xsl:attribute name="writeable">true</xsl:attribute>
          </xsl:if>

          <xsl:if test="@readonly = 'true'">
            <xsl:attribute name="readonly">true</xsl:attribute>
          </xsl:if>

          <xsl:if test="@checkbox = 'true'">
            <xsl:attribute name="checkbox">true</xsl:attribute>
          </xsl:if>
          <xsl:if test="@expandlvl">
            <xsl:attribute name="expandlvl">
              <xsl:value-of select="@expandlvl"/>
            </xsl:attribute>
          </xsl:if>
          <!-- MSC2的extendlevel属性在MSC3中替换为expandlvl -->
          <xsl:if test="@extendlevel">
            <xsl:attribute name="expandlvl">
              <xsl:value-of select="@extendlevel"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="not(@submitall) or @submitall = 'false'">
            <xsl:attribute name="submitall">false</xsl:attribute>
          </xsl:if>
          <!-- 添加属性submitall=true时MSC3的显示 -->
          <xsl:if test="@submitall = 'true'">
            <xsl:attribute name="submitall">true</xsl:attribute>
          </xsl:if>
          <xsl:if test="item">
            <xsl:apply-templates select="item" mode="multiselect" />
          </xsl:if>
        </combotree>
      </xsl:when>
      <xsl:when test="@type = 'multiselect' and @style = 'formtree' and //body/@fullbody = 'true'">
        <tree>
          <xsl:if test="@name">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@caption">
            <xsl:attribute name="caption">
              <xsl:value-of select="@caption"/>
            </xsl:attribute>
          </xsl:if>
		  <xsl:if test="@select ='false' or not(@select)">
            <xsl:attribute name="select">false</xsl:attribute>
          </xsl:if>
          <xsl:if test="@select ='true'">
            <xsl:attribute name="select">true</xsl:attribute>
          </xsl:if>
          <xsl:if test="@expandlvl">
            <xsl:attribute name="expandlvl">
              <xsl:value-of select="@expandlvl"/>
            </xsl:attribute>
          </xsl:if>
          <!-- 添加tree節點下的expandlvl屬性顯示 -->
          <!-- MSC2的extendlevel属性在MSC3中替换为expandlvl -->
          <xsl:if test="@extendlevel">
            <xsl:attribute name="expandlvl">
              <xsl:value-of select="@extendlevel"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="item">
            <xsl:apply-templates select="item" mode="multiselect" />
          </xsl:if>

        </tree>
      </xsl:when>
      <xsl:when test="@type = 'date_time' or @type = 'date' or @type = 'time'">
        <date_time>
          <xsl:choose>
            <xsl:when test="@type = 'date_time'">
              <xsl:attribute name="mode">datetime</xsl:attribute>
            </xsl:when>
            <xsl:when test="@type = 'date'">
              <xsl:attribute name="mode">date</xsl:attribute>
            </xsl:when>
            <xsl:when test="@type = 'time'">
                <xsl:attribute name="mode">time</xsl:attribute>
              </xsl:when>
          </xsl:choose>

          <xsl:if test="@name">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@value">
            <xsl:attribute name="value">
              <xsl:value-of select="@value"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@caption">
            <xsl:attribute name="caption">
              <xsl:value-of select="@caption"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@enable = 'false'">
            <xsl:attribute name="enable">false</xsl:attribute>
          </xsl:if>
          
          <xsl:if test="@readonly = 'true'">
          	<xsl:attribute name="readonly">true</xsl:attribute>
          </xsl:if>
        </date_time>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!--解析object::multiselect:item-->
  <xsl:template match="item" mode="multiselect">
    <treeitem>
      <xsl:if test="@caption">
        <xsl:attribute name="caption">
          <xsl:value-of select="@caption"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@value">
        <xsl:attribute name="value">
          <xsl:value-of select="@value"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@childurl">
        <xsl:attribute name="childurl">
          <xsl:value-of select="@childurl"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@href">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@target">
        <xsl:attribute name="target">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@selected = 'true'">
        <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>
      <!-- 添加treeitem的selected属性=false的MSC3显示 -->
      <xsl:if test="@selected = 'false'">
            <xsl:attribute name="selected">false</xsl:attribute>
          </xsl:if>
      <xsl:if test="item">
        <xsl:apply-templates select="item" mode="multiselect" />
      </xsl:if>
    </treeitem>
  </xsl:template>

  <!--处理input 标签-->
  <xsl:template match="input">
    <xsl:choose>
      <xsl:when test="@type = 'button' or @type = 'submit' or @type = 'reset'">
        <input type="{@type}" caption="{@caption}">
          <xsl:if test="@name">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@value">
            <xsl:attribute name="value">
              <xsl:value-of select="@value"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@href">
            <xsl:attribute name="href">
              <xsl:value-of select="@href"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@target">
            <xsl:attribute name="target">
              <xsl:value-of select="@target"/>
            </xsl:attribute>
          </xsl:if>
        </input>
      </xsl:when>
      <xsl:when test="@type = 'checkbox' or @type = 'radio'">
        <input type="{@type}" caption="{@caption}">
          <xsl:if test="@name">
            <xsl:attribute name="name">
              <xsl:value-of select="@name"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@value">
            <xsl:attribute name="value">
              <xsl:value-of select="@value"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:if test="@checked = 'true'">
            <xsl:attribute name="checked">true</xsl:attribute>
          </xsl:if>
        </input>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@caption != '' and @type != 'hidden'">
            <span width="100%">
              <span width="45%">
                <xsl:value-of select="@caption"/>
              </span>
              <span width="50%">
                <xsl:call-template name="handleInput" />
              </span>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="handleInput" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--处理input 标签-->
  <xsl:template name="handleInput">
    <input>
      <xsl:choose>
        <xsl:when test="not(@type) or @type = '' or @type = 'text'">
          <xsl:attribute name="type">text</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="@name">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@value">
        <xsl:attribute name="value">
          <xsl:value-of select="@value"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@readonly = 'true'">
        <xsl:attribute name="readonly">true</xsl:attribute>
      </xsl:if>
    </input>
  </xsl:template>

  <!--解析textarea标签-->
  <xsl:template match="textarea">
    <textarea>
      <xsl:if test="@name">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@line">
        <xsl:attribute name="line">
          <xsl:value-of select="@line"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@caption">
        <xsl:attribute name="caption">
          <xsl:value-of select="@caption"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@commonphrase">
        <xsl:attribute name="commonphrase">
          <xsl:value-of select="@commonphrase"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:if test="@readonly = 'true' or @readonly = 'false'">
        <xsl:attribute name="readonly">
        	<xsl:value-of select="@readonly"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </textarea>
  </xsl:template>
  
  <!--解析普通的select标签-->
  <xsl:template match="select">
    <xsl:choose>
      <xsl:when test="@caption != ''">
        <span width="100%">
          <span width="45%">
            <xsl:value-of select="@caption"/>
          </span>
          <span width="50%">
            <xsl:call-template name="handleSelect" />
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="handleSelect" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--解析object[@type = 'navigation']::select标签-->
  <xsl:template match="select" mode="navigation">
  
      <!-- mc 修改 将msc2中select标签caption属性值取出放在font标签中显示 -->
       <span width="48%" align="left">
      <xsl:if test="@caption != ''">
        <font>
          <xsl:value-of select="@caption"/>
        </font>
      </xsl:if>
      <xsl:if test="@align = 'right'">
        <xsl:attribute name="align">right</xsl:attribute>
      </xsl:if>
      
        
     <!-- 将msc2中select标签下的caption属性放在font标签下显示 -->
        <xsl:if test="not(@value) and @caption">
          <font>
            <xsl:value-of select="@caption"/>
          </font>
        </xsl:if>
        
      <select width="100%">
        <xsl:if test="@name">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:if>
        
<!-- ***********************msc3中select标签下没有value和caption属性，两个属性在option中存在*************************** -->
       <!--  
        <xsl:if test="@value">
          <xsl:attribute name="value">
            <xsl:value-of select="@value"/>
          </xsl:attribute>
        </xsl:if>
        
        <xsl:if test="not(@value) and @caption">
          <xsl:attribute name="value">
            <xsl:value-of select="@caption"/>
          </xsl:attribute>
        </xsl:if>
        -->
<!-- ***********************msc3中select标签下没有value和caption属性，两个属性在option中存在*************************** -->  
        <xsl:if test="@readonly = 'true' or @readonly = 'false'">
          <xsl:attribute name="readonly">
            <xsl:value-of select="@readonly"/>
          </xsl:attribute>
        </xsl:if>
        
        <xsl:if test="option">
          <xsl:apply-templates select="option" mode="selectOption" />
        </xsl:if>
      </select>
    </span>
  </xsl:template>
  
  <!--解析select标签-->
  <xsl:template name="handleSelect">
    <select>
      <xsl:if test="@name">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@writeable = 'true'">
        <xsl:attribute name="writeable">true</xsl:attribute>
      </xsl:if>

<!-- ***********************msc3中select标签下没有value和caption属性，两个属性在option中存在*************************** --> 
     <!--  
      <xsl:if test="@value">
        <xsl:attribute name="value">
          <xsl:value-of select="@value"/>
        </xsl:attribute>
      </xsl:if>
      -->
 <!-- ***********************msc3中select标签下没有value和caption属性，两个属性在option中存在*************************** -->
       
      <xsl:if test="@readonly = 'true' or @readonly = 'false'">
          <xsl:attribute name="readonly">
            <xsl:value-of select="@readonly"/>
          </xsl:attribute>
      </xsl:if>
      
      <xsl:if test="option">
        <xsl:apply-templates select="option" mode="selectOption" />
      </xsl:if>
    </select>
  </xsl:template>

  <!--解析select::option标签-->
  <xsl:template match="option" mode="selectOption">
    <option>
      <xsl:if test="@name">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@value">
        <xsl:attribute name="value">
          <xsl:value-of select="@value"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@href">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@target">
        <xsl:attribute name="target">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@selected= 'true'">
        <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>

      <xsl:value-of select="."/>
    </option>
  </xsl:template>

  <!--解析font标签-->
  <xsl:template match="font">
    <xsl:choose>
      <xsl:when test="@align">
        <span width="100%" align="{@align}">
          <xsl:apply-templates select="." mode="handleFont"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="handleFont"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--解析font标签-->
  <xsl:template match="font" mode="handleFont">
    <font color="{@color}">
      <xsl:attribute name="size">
        <xsl:choose>
          <xsl:when test="@size = 'small'">xs</xsl:when>
          <xsl:when test="@size = 'large'">xl</xsl:when>
          <xsl:otherwise>m</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@bold = 'true'">
          <strong>
            <xsl:value-of select="."/>
          </strong>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </font>
  </xsl:template>
  
    <!--解析a标签-->
  <xsl:template match="a">
    <xsl:choose>
      <xsl:when test="@href != ''">
        <a href="{@href}" target="{@target}">
          <xsl:value-of select="."/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="img">
    <img src="{@src}">
      <xsl:if test="@href">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@target">
        <xsl:attribute name="target">
          <xsl:value-of select="@target"/>
        </xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <!--copy hr|br|login-->
  <xsl:template match="hr|br|login">
    <xsl:copy />
  </xsl:template>
  
  <!--解析MSC2的servermsg标签-->
   <xsl:template match="msg" mode="servermsg">
    <msg  buttonstyle="OKCancel">
      <xsl:choose>
        <xsl:when test="@isshow and @isshow = '0'">
          <xsl:attribute name="show">false</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="show">true</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="text()"/>
    </msg>
    <xsl:if test="@nextaction != ''">
      <script>
        <xsl:call-template  name="handleNextAction">
          <xsl:with-param name="param" select="@nextaction"></xsl:with-param>
        </xsl:call-template>
      </script>
    </xsl:if>
  </xsl:template>

  <!--解析MSC2的servermsg::nextaction-->
  <xsl:template name="handleNextAction">
    <xsl:param name="param"></xsl:param>
    <xsl:if test="contains($param,'|')">
      <xsl:choose>
        <xsl:when test="substring-before($param,'|') = 'closeme'">application.getActiveWindow().close();</xsl:when>
        <xsl:when test="substring-before($param,'|') = 'refresh'">application.getActiveWindow().refresh();</xsl:when>
        <xsl:when test="substring-before($param,'|') = 'gohome'">application.getActiveWindow().gohome();</xsl:when>
        <xsl:when test="substring-before($param,'|') = 'exit'">application.getActiveWindow().exit();</xsl:when>
        <xsl:when test="substring-before($param,'|') = 'gologin'">application.getActiveWindow().gologin();</xsl:when>
        <xsl:when test="starts-with(substring-before($param,'|'),'redirect(')">application.getActiveWindow().location.href='<xsl:value-of select="substring-before(substring-after(substring-before($param,'|'),'redirect('),')')"/>';</xsl:when>
      </xsl:choose>
      <xsl:call-template name="handleNextAction">
        <xsl:with-param name="param" select="substring-after($param,'|')"></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="not(contains($param,'|'))">
      <xsl:choose>
        <xsl:when test="$param = 'closeme'">application.getActiveWindow().close();</xsl:when>
        <xsl:when test="$param = 'refresh'">application.getActiveWindow().refresh();</xsl:when>
        <xsl:when test="$param = 'gohome'">application.getActiveWindow().gohome();</xsl:when>
        <xsl:when test="$param = 'exit'">application.getActiveWindow().exit();</xsl:when>
        <xsl:when test="$param = 'gologin'">application.getActiveWindow().gologin();</xsl:when>
        <xsl:when test="starts-with($param,'redirect(')">application.getActiveWindow().location.href='<xsl:value-of select="substring-before(substring-after($param,'redirect('),')')"/>';</xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!--解析MSC2的fileset::fileitem-->
  <xsl:template match="item" mode="fileset">
    <fileitem>
      <xsl:if test="@text">
        <xsl:attribute name="caption">
          <xsl:value-of select="@text"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@ft">
        <xsl:attribute name="filetype">
          <xsl:value-of select="@ft"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="not(@ft) and contains(@text,'.')">
        <xsl:attribute name="filetype">
          <xsl:value-of select="substring-after(@text,'.')"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="@href">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
      </xsl:if>

<!-- *************************去掉了size属性************************ -->
      <!--  <xsl:if test="@size">
        <xsl:attribute name="size">
          <xsl:value-of select="@size"/>
        </xsl:attribute>
      </xsl:if>
	 -->
<!-- *************************去掉了size属性************************ -->	 
	 
      <xsl:if test="@lm">
        <xsl:attribute name="lm">
          <xsl:value-of select="@lm"/>
        </xsl:attribute>
      </xsl:if>
    </fileitem>
  </xsl:template>

  <!--解析MSC2标签 End-->
  
  <xsl:template match="userdefined" mode="userdefined">
  	<!-- <xsl:copy  />baseweb中使用copy-of	 -->
  	<xsl:copy-of select="."/>
  </xsl:template>
  
  
</xsl:stylesheet>