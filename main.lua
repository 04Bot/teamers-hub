local v0=Instance.new("ScreenGui");v0.ResetOnSpawn=false;v0.AutoLocalize=false;v0.Parent=game.Players.LocalPlayer.PlayerGui;local v5=Instance.new("TextButton");v5.BackgroundTransparency=0.5;v5.BackgroundColor3=Color3.new(0,0 -0 ,0);v5.TextColor3=Color3.new(2 -1 ,1 + 0 ,1 -0 );v5.RichText=true;v5.Text="<b>Close GUI</b>";v5.Position=UDim2.new(0.093 -0 ,0 -0 ,0.402 + 0 ,0 -0 );v5.Size=UDim2.new(0,235 -175 ,0,1 + 59 );v5.Parent=v0;local v14=Instance.new("UICorner");v14.CornerRadius=UDim.new(0 + 0 ,1071 -(87 + 968) );v14.Parent=v5;local v17=Instance.new("Frame");v17.BackgroundTransparency=0.5;v17.BackgroundColor3=Color3.new(0,0,0 -0 );v17.Position=UDim2.new(0.475 + 0 ,0 -0 ,1413.157 -(447 + 966) ,0 -0 );v17.Size=UDim2.new(1817 -(1703 + 114) ,1043 -(376 + 325) ,0 -0 ,636 -429 );v17.Parent=v0;local v23=Instance.new("UICorner");v23.CornerRadius=UDim.new(0 + 0 ,34 -18 );v23.Parent=v17;local v26=Instance.new("ScrollingFrame");v26.BackgroundTransparency=15 -(9 + 5) ;v26.Position=UDim2.new(0.067,376 -(85 + 291) ,1265.121 -(243 + 1022) ,0);v26.Size=UDim2.new(0,1126 -830 ,0 + 0 ,1362 -(1123 + 57) );v26.CanvasSize=UDim2.new(0,0,0,0);v26.Parent=v17;local v32=Instance.new("UIListLayout");v32.Padding=UDim.new(0 + 0 ,4);v32.Parent=v26;local v35=Instance.new("Frame");v35.Position=UDim2.new(0.475,254 -(163 + 91) ,1930.156 -(1869 + 61) ,0 + 0 );v35.Size=UDim2.new(0 -0 ,524 -182 ,0 + 0 ,25 -6 );v35.BackgroundColor3=Color3.new(0 + 0 ,1474 -(1329 + 145) ,0);v35.Parent=v0;local v40=Instance.new("UICorner");v40.CornerRadius=UDim.new(971 -(140 + 831) ,16);v40.Parent=v35;local v43=Instance.new("TextLabel");v43.Size=UDim2.new(0,2192 -(1409 + 441) ,718 -(15 + 703) ,9 + 10 );v43.RichText=true;v43.Text="<b>Teamers Hub</b>";v43.TextSize=458 -(262 + 176) ;v43.TextColor3=Color3.new(1722 -(345 + 1376) ,689 -(198 + 490) ,4 -3 );v43.BackgroundTransparency=1;v43.Font=Enum.Font.SourceSans;v43.Parent=v35;local function v53(v74) local v75=Instance.new("Frame");v75.BackgroundTransparency=0.7 -0 ;v75.BackgroundColor3=Color3.new(1206 -(696 + 510) ,0 -0 ,1262 -(1091 + 171) );v75.Size=UDim2.new(0 + 0 ,931 -635 ,0,34);v75.Parent=v26;local v80=Instance.new("UICorner");v80.CornerRadius=UDim.new(0,26 -18 );v80.Parent=v75;local v83=Instance.new("TextButton");v83.BackgroundTransparency=375 -(123 + 251) ;v83.Text="";v83.BackgroundColor3=Color3.new(0,0.576471 -0 ,698.866667 -(208 + 490) );v83.Position=UDim2.new(0.833,0,0.221 + 0 ,0);v83.Size=UDim2.new(0 + 0 ,34,0,855 -(660 + 176) );v83.Parent=v75;local v90=Instance.new("UICorner");v90.CornerRadius=UDim.new(0,3 + 16 );v90.Parent=v83;local v93=Instance.new("UIStroke");v93.Color=Color3.new(202.52549 -(14 + 188) ,675.52549 -(534 + 141) ,0.52549 + 0 );v93.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;v93.Thickness=1.5 + 0 ;v93.Parent=v83;local v99=Instance.new("Frame");v99.BackgroundColor3=Color3.new(0.52549 + 0 ,0.52549 -0 ,0.52549 -0 );v99.Position=UDim2.new(0.05 -0 ,0 + 0 ,0.097 + 0 ,396 -(115 + 281) );v99.Size=UDim2.new(0,34 -19 ,0 + 0 ,15);v99.Parent=v83;local v104=Instance.new("UICorner");v104.CornerRadius=UDim.new(0 -0 ,183 -133 );v104.Parent=v99;local v107=Instance.new("TextLabel");v107.RichText=true;v107.Text="<b>"   .. tostring(v74)   .. "</b>" ;v107.BackgroundTransparency=1;v107.TextSize=882 -(550 + 317) ;v107.Size=UDim2.new(0,162 -49 ,0 -0 ,94 -60 );v107.TextColor3=Color3.new(286 -(134 + 151) ,1666 -(970 + 695) ,1 -0 );v107.Font=Enum.Font.SourceSans;v107.Parent=v75;return v83;end local v54=v53("Auto Farm");local v55=v53("Blurt Role");local v56=false;local v57=game.Players.LocalPlayer;local v58=v57.Character or v57.CharacterAdded:Wait() ;local v59=v58:WaitForChild("HumanoidRootPart");local v60=v58:WaitForChild("Humanoid");local v61=game:GetService("TweenService");local v62;local v63;local function v64(v117) for v137,v138 in ipairs(v58:GetDescendants()) do if (v138:IsA("BasePart") or v138:IsA("MeshPart")) then v138.CanCollide= not v117;end end end local function v65(v118,v119) local v120=1990 -(582 + 1408) ;local v121;local v122;while true do if (v120==(3 -2)) then v122:Play();break;end if (v120==0) then v121=TweenInfo.new(0.1 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out);v122=v61:Create(v118,v121,{Position=v119});v120=3 -2 ;end end end local v66=25;local function v67() local v123=nil;local v124=math.huge;for v139,v140 in ipairs(game.Workspace:GetDescendants()) do if (v140.Name=="CoinContainer") then for v153,v154 in ipairs(v140:GetDescendants()) do if v154:IsA("MeshPart") then if  not v154.Parent:FindFirstChild("TouchInterest") then continue;end local v164=(v154.Position-v59.Position).Magnitude;if (v164<v124) then local v171=1824 -(1195 + 629) ;local v172;while true do if (v171==0) then v172=0 -0 ;while true do if (v172==0) then v124=v164;v123=v154;break;end end break;end end end end end end end return v123,v124;end local v68=false;local function v69() if ( not v56 or v68) then return;end v68=true;local v125,v126=v67();if v125 then v64(true);local v141;v141=v125.AncestryChanged:Connect(function() if  not v125:IsDescendantOf(workspace) then local v155=0;local v156;while true do if (0==v155) then v156=241 -(187 + 54) ;while true do if (v156==(782 -(162 + 618))) then v69();break;end if (v156==1) then wait(0.1);v68=false;v156=2 + 0 ;end if (v156==0) then v141:Disconnect();v64(false);v156=1 + 0 ;end end break;end end end end);if (v126<=(1 -0)) then v141:Disconnect();v64(false);wait(0.1 -0 );v68=false;v69();elseif (v126>(24 + 276)) then local v165=1636 -(1373 + 263) ;while true do if (v165==0) then if v62 then v62:Cancel();end v59.CFrame=CFrame.new(v125.Position.X,v125.Position.Y + (1000.5 -(451 + 549)) ,v125.Position.Z);v165=1 + 0 ;end if ((1 -0)==v165) then v141:Disconnect();v68=false;v165=2 -0 ;end if (v165==2) then v69();break;end end else local v166=1384 -(746 + 638) ;local v167;local v168;local v169;while true do if ((1 + 1)==v166) then v62:Play();v62.Completed:Connect(function() v141:Disconnect();v64(false);wait(0.1 -0 );v68=false;v69();end);break;end if (v166==0) then v167=v126/v66 ;v168=TweenInfo.new(v167,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);v166=342 -(218 + 123) ;end if (v166==(1582 -(1535 + 46))) then v169=CFrame.new(v125.Position.X,v125.Position.Y,v125.Position.Z);v62=v61:Create(v59,v168,{CFrame=v169});v166=2;end end end else local v142=0;while true do if (v142==(0 + 0)) then print("Aucune pièce trouvée.");v64(false);v142=1 + 0 ;end if (v142==(562 -(306 + 254))) then v69();break;end if (v142==1) then v68=false;wait(1 + 0 );v142=3 -1 ;end end end end local function v70() local v127=1467 -(899 + 568) ;local v128;while true do if (v127==0) then v128=v57.PlayerGui.MainGUI.Game.CoinBags.Container.Candy.CurrencyFrame.Icon.Coins;v128:GetPropertyChangedSignal("Text"):Connect(function() if (v128.Text=="40") then v57.Character.Humanoid.Health=0 + 0 ;end end);break;end end end local function v71() local v129=0;while true do if ((4 -2)==v129) then v63.Parent=v58.HumanoidRootPart;v56=true;v129=3;end if (v129==(606 -(268 + 335))) then v70();v69();break;end if (v129==(290 -(60 + 230))) then v63=Instance.new("BodyPosition");v63.P=0;v129=573 -(426 + 146) ;end if (v129==(1 + 0)) then v63.D=1456 -(282 + 1174) ;v63.MaxForce=Vector3.new(math.huge,math.huge,math.huge);v129=813 -(569 + 242) ;end end end local function v72() local v130=0 -0 ;local v131;while true do if (v130==(0 + 0)) then v131=1024 -(706 + 318) ;while true do if (v131==(1251 -(721 + 530))) then v56=false;v63:Destroy();v131=1272 -(945 + 326) ;end if (v131==1) then v62:Cancel();v64(false);break;end end break;end end end v54.MouseButton1Click:Connect(function() local v132=0 -0 ;local v133;local v134;while true do if (v132==(1 + 0)) then if v56 then local v157=700 -(271 + 429) ;while true do if (v157==0) then v133.BackgroundTransparency=1;v134.BackgroundColor3=Color3.new(0.52549 + 0 ,1500.52549 -(1408 + 92) ,1086.52549 -(461 + 625) );v157=1289 -(993 + 295) ;end if (v157==(1 + 0)) then v65(v134,UDim2.new(1171.05 -(418 + 753) ,0 + 0 ,0.089 + 0 ,0 + 0 ));v72();break;end end else local v158=0;local v159;while true do if (v158==(0 + 0)) then v159=529 -(406 + 123) ;while true do if (v159==(1770 -(1749 + 20))) then v65(v134,UDim2.new(0.5 + 0 ,1322 -(1249 + 73) ,0.089 + 0 ,0));v71();break;end if (v159==0) then v133.BackgroundTransparency=1145 -(466 + 679) ;v134.BackgroundColor3=Color3.new(0 -0 ,0 -0 ,0);v159=1901 -(106 + 1794) ;end end break;end end end break;end if (v132==0) then v133=v54;v134=v133:FindFirstChild("Frame");v132=1;end end end);v5.MouseButton1Click:Connect(function() if (v5.Text=="<b>Close GUI</b>") then local v143=0 + 0 ;local v144;while true do if (v143==0) then v144=0 + 0 ;while true do if (v144==(2 -1)) then v5.Text="<b>Open GUI</b>";break;end if (v144==(0 -0)) then v17.Visible=false;v35.Visible=false;v144=115 -(4 + 110) ;end end break;end end else local v145=584 -(57 + 527) ;while true do if (v145==1) then v5.Text="<b>Close GUI</b>";break;end if (v145==0) then v17.Visible=true;v35.Visible=true;v145=1428 -(41 + 1386) ;end end end end);local function v73(v135) local v136=103 -(17 + 86) ;while true do if (v136==(0 + 0)) then v58=v135;v59=v58:WaitForChild("HumanoidRootPart");v136=1 -0 ;end if (v136==(2 -1)) then if v56 then local v163=166 -(122 + 44) ;while true do if (v163==1) then v71();v70();break;end if (v163==(0 -0)) then v72();wait(6 -4 );v163=1;end end end break;end end end v57.CharacterAdded:Connect(v73);v58=v57.Character or v57.CharacterAdded:Wait() ;v59=v58:WaitForChild("HumanoidRootPart");
-- ⚠️ WARNING: integrity protected!
--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--
