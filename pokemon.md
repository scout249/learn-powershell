以下是一个关于如何使用 Invoke-RestMethod 从网上获取 JSON 数据的中文教程。

# 使用 PowerShell 的 Invoke-RestMethod 获取 JSON 数据教程

![Pikachu](https://raw.githubusercontent.com/Purukitto/pokemon-data.json/master/images/pokedex/thumbnails/025.png)

# Table of Contents
1. [📥 获取数据](#1--获取数据)
1. [🔍 过滤数据](#2-过滤数据)
    1. [greater-than](#gt-greater-than)
    1. [less-than](#lt-less-than)
    1. [contains](#contains)
    1. [match](#match)
1. [📊 格式化数据](#3--格式化数据)
    1. [使用-format-table](#使用-format-table)
    1. [使用-format-list](#使用-format-list)
    1. [使用-out-gridview](#使用-out-gridview)
1. [📸 下载图片](#4--下载图片)
1. [使用-out-gridview-和-passthru-下载多张图片](#5-使用-out-gridview-和-passthru-下载多张图片)
1. [随机选择两个宝可梦并比较它们的-hp](#6-随机选择两个宝可梦并比较它们的-hp)
    1. [挑战问题](#挑战问题)
1. [导出文件](7-导出文件)
    1. [导出为-csv-文件](#导出为-csv-文件)
    1. [导出为-html-文件](#导出为-html-文件)
1. [保存宝可梦信息到 txt](#8--保存宝可梦信息到-txt)


## 1. 📥 获取数据

PowerShell ISE（集成脚本环境）是一个图形化的脚本编辑器，提供了编写、测试和调试PowerShell脚本的功能。以下是一个教程，指导你如何使用PowerShell ISE编写和运行脚本。

###  打开PowerShell ISE 步骤
1. 按 `Win + R` 打开运行对话框。
1. 输入 `powershell_ise` 并按 **Enter**。
1. 在PowerShell ISE中，点击脚本窗格上方的绿色“运行脚本”按钮，或者按 **F5** 键。脚本将运行，并在控制台窗格中显示输出。

首先，我们使用 `Invoke-RestMethod` 从网上获取 JSON 数据。以下是一个示例：

`$data | Format-Table` 是 PowerShell 中用于格式化和显示数据的一种方式。
`$data | Format-Table` 命令将 `$data` 中的数据以表格形式显示出来。它会自动调整列宽，使数据更易于阅读和理解。

```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json
$data | Format-Table
```


```
 id name                                                                      
 -- ----                                                                      
  1 @{english=Bulbasaur; japanese=フシギダネ; chinese=妙蛙种子; french=Bulbizarre}     
  2 @{english=Ivysaur; japanese=フシギソウ; chinese=妙蛙草; french=Herbizarre}        
  3 @{english=Venusaur; japanese=フシギバナ; chinese=妙蛙花; french=Florizarre}
...
896 @{english=Glastrier; japanese=ブリザポス; chinese=雪暴马; french=Blizzeval}       
897 @{english=Spectrier; japanese=レイスポス; chinese=灵幽马; french=Spectreval}      
898 @{english=Calyrex; japanese=バドレックス; chinese=蕾冠王; french=Sylveroy} 
```

你可以指定要显示的列，或者让 PowerShell 自动选择适当的列。
```
$data | Format-Table -Property name, base
```



## 2.🔍 过滤数据 
接下来，我们可以根据特定条件过滤数据。例如，过滤出英文名字包含 "pika" 的宝可梦：

```powershell
$filtered_pokemon = $data | Where-Object { $_.name.english -match "pika" }
$filtered_pokemon
```

```
id          : 25
name        : @{english=Pikachu; japanese=ピカチュウ; chinese=皮卡丘; french=Pikachu}
type        : {Electric}
base        : @{HP=35; Attack=55; Defense=40; Sp. Attack=50; Sp. Defense=50; 
              Speed=90}
species     : Mouse Pokémon
description : While sleeping, it generates electricity in the sacs in its 
              cheeks. If it’s not getting enough sleep, it will be able to use 
              only weak electricity.
evolution   : @{prev=System.Object[]; next=System.Object[]}
profile     : @{height=0.4 m; weight=6 kg; egg=System.Object[]; 
              ability=System.Object[]; gender=50:50}
image       : @{sprite=https://raw.githubusercontent.com/Purukitto/pokemon-data
              .json/master/images/pokedex/sprites/025.png; thumbnail=https://ra
              w.githubusercontent.com/Purukitto/pokemon-data.json/master/images
              /pokedex/thumbnails/025.png; hires=https://raw.githubusercontent.
              com/Purukitto/pokemon-data.json/master/images/pokedex/hires/025.p
              ng}
```


在 PowerShell 中，gt、lt 和 contains 是用于比较和过滤数据的运算符：

### gt (Greater Than)
gt 表示“大于”。它用于比较数值，返回大于指定值的项。例如，过滤出 HP 大于 70 的宝可梦：
```powershell
$filtered_pokemon = $data | Where-Object { $_.base.HP -gt 70 }
$filtered_pokemon
```


### lt (Less Than)
lt 表示“小于”。它用于比较数值，返回小于指定值的项。例如，过滤出 HP 小于 70 的宝可梦：
```powershell
$filtered_pokemon = $data | Where-Object { $_.base.HP -lt 70 }
$filtered_pokemon
```
### contains
contains 用于检查字符串是否包含指定的子字符串。例如，过滤出英文名字包含 "pika" 的宝可梦：
```powershell
$filtered_pokemon = $data | Where-Object { $_.name.english -contains "pika" }
$filtered_pokemon
```

### match
不过，在 PowerShell 中，检查字符串包含子字符串更常用的是 -match 运算符，如提供的示例：
```powershell
$filtered_pokemon = $data | Where-Object { $_.name.english -match "pika" }
$filtered_pokemon
```
-match 运算符用于正则表达式匹配，适用于更复杂的字符串匹配需求。

## 3. 📊 格式化数据
我们可以使用 Format-Table、Format-List 和 Out-GridView 来格式化和查看数据。

### 使用 Format-Table
```powershell
$filtered_pokemon | Format-Table -Property name, base
```
### 使用 Format-List
```powershell
$filtered_pokemon | Format-List -Property name, base
```
### 使用 Out-GridView
```powershell
$filtered_pokemon | Out-GridView
```
**显示数据:** `Out-GridView` 将数据以表格形式显示在一个独立的窗口中，方便用户查看和分析。

**排序:** 你可以通过点击列标题来对数据进行升序或降序排序。

**过滤:** 在窗口的顶部有一个过滤框，你可以输入文本来快速过滤显示的数据。例如，输入 "皮卡丘" 来过滤显示包含该名称的宝可梦。

## 4. 📸 下载图片
我们可以下载过滤后的宝可梦的图片到本地目录。例如，下载高分辨率图片到 C:\temp\：
```powershell
$destination_folder = "C:\temp"
if (-not (Test-Path -Path $destination_folder)) {
    New-Item -ItemType Directory -Path $destination_folder
}

foreach ($pokemon in $filtered_pokemon) {
    $image_url = $pokemon.image.hires
    $file_name = [System.IO.Path]::GetFileName($image_url)
    $destination_path = Join-Path -Path $destination_folder -ChildPath $file_name
    Invoke-WebRequest -Uri $image_url -OutFile $destination_path
}

Write-Output "Images downloaded to $destination_folder"
```
## 5. 使用 Out-GridView 和 PassThru 下载多张图片
我们可以使用 `Out-GridView` 的 `-PassThru` 参数来选择并下载多张图片，你可以通过按住 CTRL 键并点击来选择多个项目：
```powershell
$selected_pokemon = $filtered_pokemon | Out-GridView -PassThru

foreach ($pokemon in $selected_pokemon) {
    $image_url = $pokemon.image.hires
    $file_name = [System.IO.Path]::GetFileName($image_url)
    $destination_path = Join-Path -Path $destination_folder -ChildPath $file_name
    Invoke-WebRequest -Uri $image_url -OutFile $destination_path
}

Write-Output "Selected images downloaded to $destination_folder"
```
选择多个项目的步骤：
1. 运行上述脚本时，会弹出一个 Out-GridView 窗口，显示过滤后的宝可梦列表。
2. 在 `Out-GridView` 窗口中，按住 CTRL 键。
3. 使用鼠标点击你想要选择的多个宝可梦条目。
4. 选择完成后，点击窗口底部的“确定”按钮。
这样，你选择的多个宝可梦的图片将会被下载到指定的文件夹中。

通过以上步骤，你可以使用 PowerShell 从网上获取 JSON 数据，过滤数据，格式化数据，并下载图片。

## 6. 随机选择两个宝可梦并比较它们的 HP

### 使用 PowerShell 随机选择并比较两个宝可梦的 HP

### 随机选择两个宝可梦

接下来，我们使用 `Get-Random` 随机选择两个宝可梦：
```powershell
$random_pokemon = $data | Get-Random -Count 2
```

### 比较 HP 并输出结果
```powershell
$pokemon1 = $random_pokemon[0]
$pokemon2 = $random_pokemon[1]

$hp1 = $pokemon1.base.HP
$hp2 = $pokemon2.base.HP

if ($hp1 -gt $hp2) {
    Write-Output "$($pokemon1.name.chinese) has $hp1 HP, $($pokemon2.name.chinese) has $hp2 HP, $($pokemon1.name.chinese) wins"
} elseif ($hp1 -lt $hp2) {
    Write-Output "$($pokemon2.name.chinese) has $hp2 HP, $($pokemon1.name.chinese) has $hp1 HP, $($pokemon2.name.chinese) wins"
} else {
    Write-Output "$($pokemon1.name.chinese) and $($pokemon2.name.chinese) both have $hp1 HP, it's a tie"
}
```

### 完整脚本
将以上步骤整合在一起，完整脚本如下：
```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json

# 随机选择两个宝可梦
$random_pokemon = $data | Get-Random -Count 2

$pokemon1 = $random_pokemon[0]
$pokemon2 = $random_pokemon[1]

$hp1 = $pokemon1.base.HP
$hp2 = $pokemon2.base.HP

# 比较 HP 并输出结果
if ($hp1 -gt $hp2) {
    Write-Output "$($pokemon1.name.chinese) has $hp1 HP, $($pokemon2.name.chinese) has $hp2 HP, $($pokemon1.name.chinese) wins"
} elseif ($hp1 -lt $hp2) {
    Write-Output "$($pokemon2.name.chinese) has $hp2 HP, $($pokemon1.name.chinese) has $hp1 HP, $($pokemon2.name.chinese) wins"
} else {
    Write-Output "$($pokemon1.name.chinese) and $($pokemon2.name.chinese) both have $hp1 HP, it's a tie"
}
```

通过以上步骤，你可以使用 PowerShell 随机选择两个宝可梦，比较它们的 HP，并输出结果。


## 挑战问题：

🎉 **挑战:** 修改脚本，将 `$pokemon1` 替换为你选择的宝可梦。例如，如果你想比较皮卡丘和一个随机选择的宝可梦，请将 `$pokemon1` 替换为皮卡丘的数据。

以下是脚本中的原始部分供参考：
```powershell
$pokemon1 = $random_pokemon[0]
$pokemon2 = $random_pokemon[1]
```
**你的任务:** 将 `$random_pokemon[0]` 替换为你选择的宝可梦的数据。你可以从 JSON 数据中找到皮卡丘或其他任何宝可梦的数据，并将其分配给 `$pokemon1`。

## 7. 导出文件

### 导出为 CSV 文件
你可以使用 `Export-Csv` cmdlet 将数据导出为 CSV 文件。
```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json

# 导出为 CSV 文件
$data | Select-Object id, name, type, base | Export-Csv -Path "C:\temp\pokemon_data.csv" -NoTypeInformation
```

### 导出为 HTML 文件
你可以使用 `ConvertTo-Html` cmdlet 将数据转换为 HTML 格式，并使用 `Out-File` 将其保存为 HTML 文件。
```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json

# 导出为 HTML 文件
$data | Select-Object id, name, type, base | ConvertTo-Html -Property id, name, type, base | Out-File -FilePath "C:\temp\pokemon_data.html"
```

### 解释
#### 导出为 CSV 文件:

- 使用 `Select-Object` 选择要导出的属性。
- 使用 `Export-Csv` 将数据导出为 CSV 文件，并指定文件路径。
#### 导出为 HTML 文件:

- 使用 `Select-Object` 选择要导出的属性。
- 使用 `ConvertTo-Html` 将数据转换为 HTML 格式。
- 使用 `Out-File` 将 HTML 数据保存到指定文件路径。

### 将数据展平并将所有数据作为列导出为 CSV 文件
要将数据展平并将所有数据作为列导出为 CSV 文件。

```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json

# 展平数据结构
$flattened_data = $data | ForEach-Object {
    [PSCustomObject]@{
        id          = $_.id
        english     = $_.name.english
        japanese    = $_.name.japanese
        chinese     = $_.name.chinese
        french      = $_.name.french
        type        = ($_ | Select-Object -ExpandProperty type) -join ", "
        HP          = $_.base.HP
        Attack      = $_.base.Attack
        Defense     = $_.base.Defense
        SpAttack    = $_.base."Sp. Attack"
        SpDefense   = $_.base."Sp. Defense"
        Speed       = $_.base.Speed
        species     = $_.species
        description = $_.description
        height      = $_.profile.height
        weight      = $_.profile.weight
        gender      = $_.profile.gender
        sprite      = $_.image.sprite
        thumbnail   = $_.image.thumbnail
        hires       = $_.image.hires
    }
}

# 导出为 CSV 文件
$flattened_data | Export-Csv -Path "C:\temp\flattened_pokemon_data.csv" -NoTypeInformation
```
展平数据结构: 使用 `ForEach-Object` 遍历每个宝可梦，并创建一个新的对象，其中包含展平后的属性。
这个脚本会将 JSON 数据展平，并将所有属性作为列导出到 CSV 文件中。

## 8. 📥 保存宝可梦信息到 TXT
如何使用PowerShell脚本从网上获取宝可梦数据，选择一个宝可梦，并将用户的名字和选择的宝可梦信息保存到文本文件中。文本文件将以UTF-8编码保存，以确保正确显示中文字符。

### 下载宝可梦数据
首先，我们从指定的URL下载宝可梦数据，并将其存储在变量 `$data` 中。
```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json
```

### 扁平化数据
接下来，我们将数据扁平化，以便于选择和处理。我们使用 `ForEach-Object` 循环遍历每个宝可梦，并创建一个自定义对象来存储相关信息。
```powershell
$flattened_data = $data | ForEach-Object {
    [PSCustomObject]@{
        id          = $_.id
        english     = $_.name.english
        japanese    = $_.name.japanese
        chinese     = $_.name.chinese
        french      = $_.name.french
        type        = ($_ | Select-Object -ExpandProperty type) -join ", "
        HP          = $_.base.HP
        Attack      = $_.base.Attack
        Defense     = $_.base.Defense
        SpAttack    = $_.base."Sp. Attack"
        SpDefense   = $_.base."Sp. Defense"
        Speed       = $_.base.Speed
        species     = $_.species
        description = $_.description
        height      = $_.profile.height
        weight      = $_.profile.weight
        gender      = $_.profile.gender
        sprite      = $_.image.sprite
        thumbnail   = $_.image.thumbnail
        hires       = $_.image.hires
    }
}
```

### 选择一个宝可梦
使用 `Out-GridView` 命令打开一个图形界面，让用户选择一个宝可梦。选择的宝可梦信息将存储在变量 `$selected_pokemon` 中。
```powershell
# Powershell 5
$selected_pokemon = $flattened_data | Select-Object english, chinese, HP | Out-GridView -Title "选择一个宝可梦" -PassThru
```

### 询问用户的名字
使用 `Read-Host` 命令询问用户的名字，并将其存储在变量 `$user_name` 中。
```powershell
$user_name = Read-Host "请输入你的名字"
```

### 获取当前日期时间
使用 `Get-Date` 命令获取当前的日期和时间，并格式化为 `yyyy-MM-dd HH:mm:ss` 格式。
```powershell
$current_datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
```

### 构建输出字符串
构建一个包含当前日期时间、用户名字、选择的宝可梦英文名、中文名和HP值的输出字符串。
```powershll
$output = "$current_datetime, Your name is $user_name, Your favorite pokemon is $($selected_pokemon.english), $($selected_pokemon.chinese), the hp is $($selected_pokemon.HP)"
```

### 以追加模式保存到文本文件
```powershell
$output_file = "C:\temp\favorite_pokemon.txt"
Add-Content -Path $output_file -Value $output -Encoding utf8
```

### 输出结果
最后，输出一条消息，告知用户信息已保存。
```powershell
Write-Output "信息已保存到 $output_file"
```

### 完整代码
```powershell
# 下载宝可梦数据
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json

# 扁平化数据
$flattened_data = $data | ForEach-Object {
    [PSCustomObject]@{
        id          = $_.id
        english     = $_.name.english
        japanese    = $_.name.japanese
        chinese     = $_.name.chinese
        french      = $_.name.french
        type        = ($_ | Select-Object -ExpandProperty type) -join ", "
        HP          = $_.base.HP
        Attack      = $_.base.Attack
        Defense     = $_.base.Defense
        SpAttack    = $_.base."Sp. Attack"
        SpDefense   = $_.base."Sp. Defense"
        Speed       = $_.base.Speed
        species     = $_.species
        description = $_.description
        height      = $_.profile.height
        weight      = $_.profile.weight
        gender      = $_.profile.gender
        sprite      = $_.image.sprite
        thumbnail   = $_.image.thumbnail
        hires       = $_.image.hires
    }
}

# 选择一个宝可梦
$selected_pokemon = $flattened_data | Select-Object english, chinese, HP | Out-GridView -Title "选择一个宝可梦" -PassThru

# 询问用户的名字
$user_name = Read-Host "请输入你的名字"

# 获取当前日期时间
$current_datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# 构建输出字符串
$output = "$current_datetime, Your name is $user_name, Your favorite pokemon is $($selected_pokemon.english), $($selected_pokemon.chinese), the hp is $($selected_pokemon.HP)"

# 以追加模式保存到文本文件，指定UTF-8编码
$output_file = "C:\temp\favorite_pokemon.txt"
Add-Content -Path $output_file -Value $output -Encoding utf8

# 输出结果
Write-Output "信息已保存到 $output_file"
```
