以下是一个关于如何使用 Invoke-RestMethod 从网上获取 JSON 数据的中文教程，使用你提供的示例。

# 使用 PowerShell 的 Invoke-RestMethod 获取 JSON 数据教程

## 1. 获取数据

首先，我们使用 `Invoke-RestMethod` 从网上获取 JSON 数据。以下是一个示例：

`$data | Format-Table` 是 PowerShell 中用于格式化和显示数据的一种方式。以下是对它的中文解释：
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



## 2. 过滤数据
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

## 3. 格式化数据
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

## 4. 下载图片
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
