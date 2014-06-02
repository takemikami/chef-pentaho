pentaho Cookbook
=====================

このCookbookはPentahoCommunityEditionをインストールします。

PentahoCommunityEditionについては以下をご覧下さい。
 http://community.pentaho.com/

Requirements
------------

対応するOSは、CentOSです。
Oracle版のJDKがインストールされている必要があります。

Attributes
----------
#### chef-infobright::install
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['pentaho']['version']</tt></td>
    <td>String</td>
    <td>PentahoCommunityEditionのバージョン</td>
    <td><tt>4.8.0</tt></td>
  </tr>
</table>

Usage
-----
#### pentaho::biserver-install
Pentaho BI Serverのインストールと自動起動設定を行います。

e.g.
Just include `chef-pentaho` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pentaho:biserver-install]"
  ]
}
```

License and Authors
-------------------
Authors: Takeshi Mikami