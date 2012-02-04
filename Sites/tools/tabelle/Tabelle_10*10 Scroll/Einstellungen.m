#import "Einstellungen.h"


@implementation Knopf

- (id)initWithFrame:(NSRect)frame
{
    if ((self = [super initWithFrame:frame]))
	return self;
	[self setButtonType:NSPushOnPushOffButton];
return 0;
}


@end

@implementation Einstellungen


- (void)awakeFromNib
{
   //
   // c-Experimente
	int a=0x20;
	int b=-1^a;
	int c=b+1;
	
	NSLog(@"a: %d b: %d c: %d",a,b,c);


   
	PList=[[NSMutableDictionary alloc]initWithCapacity:0];
	NSFileManager *Filemanager=[NSFileManager defaultManager];
	NSMutableDictionary* tempPListDic=[[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
	NSString* PListPfad=[[[NSString stringWithString:NSHomeDirectory()]
								stringByAppendingPathComponent:@"Documents"]
								stringByAppendingPathComponent:@"TabData"];
	
	BOOL istOrdner=NO;	
	if ([Filemanager fileExistsAtPath:PListPfad isDirectory:&istOrdner]&& istOrdner)
	{
		//NSLog(@"PList-Ordner da");
		if ([Filemanager fileExistsAtPath:[PListPfad stringByAppendingPathComponent:@"TabPList"]])
		{
			//NSLog(@"PList da: %@",[PList description]);
			[PList setDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:[PListPfad stringByAppendingPathComponent:@"TabPList"]]];
			//NSLog(@"PList da: %@",[PList description]);
		}
		
	}
	else
	{
		NSLog(@"PList-Ordner nicht da");
	}
	if ([PList objectForKey:@"lastmode"])
	{
		//NSLog(@"mode: %d",[[PList objectForKey:@"lastmode"]intValue]);
		[ModeSeg selectSegmentWithTag:[[PList objectForKey:@"lastmode"]intValue]];
		
	}
	if ([PList objectForKey:@"gruppendic"])
	{
		
		
      
	}
	else
	{
		NSMutableDictionary* tempGruppenDic=[[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
		[tempGruppenDic setObject:[NSNumber numberWithInt:1]forKey:@"A"];
		[tempGruppenDic setObject:[NSNumber numberWithInt:1]forKey:@"B"];
		[tempGruppenDic setObject:[NSNumber numberWithInt:1]forKey:@"C"];
		[tempGruppenDic setObject:[NSNumber numberWithInt:1]forKey:@"D"];
		[tempGruppenDic setObject:[NSNumber numberWithInt:1]forKey:@"E"];
		[tempGruppenDic setObject:[NSNumber numberWithInt:1]forKey:@"F"];
		[PList setObject:tempGruppenDic forKey:@"gruppendic"]; 
	}
	//NSLog(@"read  PList: %@",[PList description]);
	if ([PList objectForKey:@"lastgruppe"])
	{
		if ([[PList objectForKey:@"gruppendic"]objectForKey:[PList objectForKey:@"lastgruppe"]])
		{
			[Nummerfeld setIntValue:[[[PList objectForKey:@"gruppendic"]objectForKey:[PList objectForKey:@"lastgruppe"]]intValue]+1];
			[Gruppefeld selectItemWithObjectValue:[PList objectForKey:@"lastgruppe"]];
		}
	}
	else
	{
		
	}
	
	
	NSImage* TabImage = [NSImage imageNamed: @"Tab"];
	[NSApp setApplicationIconImage:TabImage];
	[Iconfeld setImage:TabImage];
	
	Tastenarray=[[[NSMutableArray alloc]initWithCapacity:0]retain];
	Wertarray=[[[NSMutableArray alloc]initWithCapacity:0]retain];
	NSRect TastenmatrixRect= [Tastenmatrixfeld bounds];
	//[[NSColor redColor]set];
	//[NSBezierPath strokeRect:MatrixRect];
	NSRect Tastenfeld=TastenmatrixRect;
	Tastenfeld.size.width=25;
	Tastenfeld.size.height=25;
	
	//NSLog(@"TastenmatrixRect: x: %d w: %2.2f",TastenmatrixRect.origin.x, TastenmatrixRect.size.width);
	int i, k;
	int d=30;
	NSRect Wertfeld;
	for(i=0;i<10;i++)//Zeile
	{
		for (k=0;k<10;k++)//Kolonne
		{
			Tastenfeld.origin.x=k*d;
			if (k>=5)
				Tastenfeld.origin.x+=5;
			Tastenfeld.origin.y=i*d;
			if (i>=5)
				Tastenfeld.origin.y+=5;
			
			NSControl * Taste=[[NSControl alloc]initWithFrame:Tastenfeld];
			//[Taste setControlType:NSRegularControlSize];
			NSButtonCell* Zelle=[[NSButtonCell alloc]init];
			[Zelle setTitle:@""];
			[Taste setTag:k+ 10*(9-i)];
			[Zelle setBordered:YES];
			[Zelle setBordered:YES];
			[Zelle setButtonType:NSOnOffButton];
			[Zelle setBezelStyle: NSCircularBezelStyle];
			[Taste setCell:Zelle];
			[Taste setAction:@selector(Tastenaktion:)];
			[Taste sizeToFit];
			[Tastenarray addObject:Taste];
			[Tastenmatrixfeld addSubview:Taste];
		}//for k
		Wertfeld=Tastenfeld;
		Wertfeld.origin.x+=2*d;
		Wertfeld.origin.y+=8;
		Wertfeld.size.height-=2;
		Wertfeld.size.width*=1.5;
		
      
		NSTextField* Wert=[[NSTextField alloc]initWithFrame:Wertfeld];
		//[Wert setBordered:YES];
		[Wert setEditable:NO];
		[Wert setSelectable:NO];
		[Wert setTag:i];
		[Wert setStringValue:@""];
		[Wert setAlignment:NSRightTextAlignment];
		
		[Wertarray addObject:Wert];
		[Tastenmatrixfeld addSubview:Wert];
		
	}//for i
	
	NSPoint w=[Ergebnisfeld frame].origin;
	w.x =Wertfeld.origin.x+[Tastenmatrixfeld frame].origin.x-6;
	//w.x+=3*d;
	[Ergebnisfeld setFrameOrigin:w];
	//[Tastenmatrixfeld addSubview:Tastenmatrix];
	
	[Ergebnisfeld setAlignment:NSRightTextAlignment];
	
	//[ModeSeg selectSegmentWithTag:0];
	int erfolg=[self makeFirstResponder:NULL];
	NSURLRequest* Anfrage=[NSURLRequest requestWithURL:[NSURL URLWithString:@"www.duernten.ch"]];
	NSLog(@"Header: %@",[[Anfrage allHTTPHeaderFields]description]);


}

- (IBAction)showArbeitsblatt:(id)sender
{
	//NSLog(@"showVorlage: ");

	if (!Arbeitsblattfenster)
	  {
		Arbeitsblattfenster=[[rArbeitsblatt alloc]init];
		
	  }
	[Arbeitsblattfenster showWindow:self];

}


- (IBAction)showVorlage:(id)sender
{
NSLog(@"showVorlage: ");

	if (!Vorlagefenster)
	  {
		Vorlagefenster=[[rVorlage alloc]init];
		
	  }
	[Vorlagefenster showWindow:self];

}

- (IBAction)setMode:(id)sender
{


}


- (IBAction)setWert:(id)sender
{


}

- (void)Tastenaktion:(id)sender
{
NSLog(@"Taste: %d",[sender tag]);
int zeile=[sender tag]/10;
int kolonne=[sender tag]%10 ;
NSLog(@"Taste: %d, zeile: %d kolonne: %d state: %d",[sender tag], zeile, kolonne,[[sender cell]state]);
int zeilenwert=[[Wertarray objectAtIndex:9-zeile]intValue];
int add;
switch ([ModeSeg selectedSegment])
{
case 0://Hundertertabelle
NSLog(@"Hundertertabelle");
add=10*(zeile)+(kolonne+1);
break;

case 1://Reihentabelle
NSLog(@"Reihentabelle");
add=(zeile+1)*(kolonne+1);
break;

}//switch

if ([[sender cell]state]==0)
{
add *=(-1);
}
zeilenwert+=add;


if (zeilenwert)
{
[[Wertarray objectAtIndex:9-zeile]setIntValue:zeilenwert];
}
else
{
[[Wertarray objectAtIndex:9-zeile]setStringValue:@""];
}

int ergebnis=[Ergebnisfeld intValue];
if (ergebnis+add)
{
[Ergebnisfeld setIntValue:ergebnis+add];
}
else
{
[Ergebnisfeld setStringValue:@""];
}

int i;
	int summe=0;
	for (i=0;i<[Tastenarray count];i++)
	{
		summe+=[[[Tastenarray objectAtIndex:i]cell] state];
	}
[Anzahlfeld setIntValue:summe];	
if (summe)
{
	//[goArbeitsblattTaste setKeyEquivalent:@"\r"];
	[self  setDefaultButtonCell:[goArbeitsblattTaste cell]];
}
else
{
	//[goArbeitsblattTaste setKeyEquivalent:@""];
	int erfolg=[self makeFirstResponder:NULL];
	[self  setDefaultButtonCell:NULL];
}
//[Aufgaberahmen setTastenwerte:WertArray];
}

- (void)reCalc
{
	int i,k, wert,add, anz;
	int summe=0;
	anz=0;
	for (i=0;i<[Wertarray count];i++)
	{
	[[Wertarray objectAtIndex:i] setStringValue:@""];
	
	}
	for (i=0;i<[Tastenarray count];i++)//zeile
	{
	if ([[[Tastenarray objectAtIndex:i] cell]state])
	{
		anz++;
		int zeile=[[Tastenarray objectAtIndex:i] tag]/10;
		int kolonne=[[Tastenarray objectAtIndex:i] tag]%10 ;
		wert=[[Wertarray objectAtIndex:9-zeile]intValue];
		switch ([ModeSeg selectedSegment])
		{
			case 0: //Hundertertabelle
				
				add=10*(zeile)+(kolonne+1);
				wert +=add;
				
				summe += add;
				break;
				
			case 1:
				add=(zeile+1)*(kolonne+1);
				wert +=add;
				summe +=add;
				
				
				break;
		}
		[[Wertarray objectAtIndex:9-zeile]setIntValue:wert];
		}//if state
	}//for i
	[Ergebnisfeld setIntValue:summe];
	[Anzahlfeld setIntValue:anz];
}

- (IBAction)switchSeg:(id)sender
{
if ([Anzahlfeld intValue])
{
[self reCalc];
}
//[self clearTasten:NULL];
}

- (IBAction)reportGruppe:(id)sender
{
	NSLog(@"reportGruppe: %@ index: %d",[sender stringValue],[sender indexOfSelectedItem]);
	int nummer=1;
	NSMutableDictionary* tempGruppenDic=(NSMutableDictionary*)[PList objectForKey:@"gruppendic"];
	if (tempGruppenDic)
	{
		switch ([sender indexOfSelectedItem])
		{
			case 0:// A
				if ([tempGruppenDic objectForKey:@"A"])
				{
					[Nummerfeld setIntValue:[[tempGruppenDic objectForKey:@"A"]intValue]+1];
				}
				[tempGruppenDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:@"A"];
				
				break;
				
			case 1:// B
				if ([tempGruppenDic objectForKey:@"B"])
				{
					[Nummerfeld setIntValue:[[tempGruppenDic objectForKey:@"B"]intValue]+1];
				}
				[tempGruppenDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:@"B"];
				
				break;
				
			case 2:// C
				if ([tempGruppenDic objectForKey:@"C"])
				{
					[Nummerfeld setIntValue:[[tempGruppenDic objectForKey:@"C"]intValue]+1];
				}
				[tempGruppenDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:@"C"];
				
				break;
				
			case 3:// D
				if ([tempGruppenDic objectForKey:@"D"])
				{
					[Nummerfeld setIntValue:[[tempGruppenDic objectForKey:@"D"]intValue]+1];
				}
				[tempGruppenDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:@"D"];
				
				break;
				
			case 4:// E
				if ([tempGruppenDic objectForKey:@"E"])
				{
					[Nummerfeld setIntValue:[[tempGruppenDic objectForKey:@"E"]intValue]+1];
				}
				[tempGruppenDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:@"E"];
				
				break;
				
			case 5:// F
				if ([tempGruppenDic objectForKey:@"F"])
				{
					[Nummerfeld setIntValue:[[tempGruppenDic objectForKey:@"F"]intValue]+1];
				}
				[tempGruppenDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:@"F"];
				
				break;
				
				
		}//switch index
	}//if tempGruppenDic

}


- (IBAction)goArbeitsblatt:(id)sender
{
	
		if (!Arbeitsblattfenster)
	  {
		Arbeitsblattfenster=[[rArbeitsblatt alloc]init];
		
	  }
	[Arbeitsblattfenster showWindow:self];

	
	NSMutableDictionary* MatrixDic=[[NSMutableDictionary alloc]initWithCapacity:0];
	NSMutableArray* stateArray=[[NSMutableArray alloc]initWithCapacity:0];
	int i;
	for (i=0;i<100;i++)
	{
	[stateArray addObject:[NSNumber numberWithInt:[[[Tastenarray objectAtIndex:i]cell]state]]];
	
	}//for i
	[MatrixDic setObject:stateArray forKey:@"Tastenwerte"];
	[MatrixDic setObject:[Gruppefeld stringValue] forKey:@"Gruppe"];
	[MatrixDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]] forKey:@"Nummer"];
	[MatrixDic setObject:[NSNumber numberWithInt:[ModeSeg selectedSegment]] forKey:@"Mode"];
	[MatrixDic setObject:[ModeSeg labelForSegment:[ModeSeg selectedSegment]] forKey:@"Titel"];
	[MatrixDic setObject:[NSNumber numberWithInt:[Anzahlfeld intValue]] forKey:@"Anzahl"];
	NSNotificationCenter* nc=[NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"Tastenwerte" object:self userInfo:MatrixDic];
	
	[[PList objectForKey:@"gruppendic"]setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:[Gruppefeld stringValue]];
}


- (IBAction)goVorlage:(id)sender
{
	
		if (!Vorlagefenster)
	  {
		Vorlagefenster=[[rVorlage alloc]init];
		
	  }
	[Vorlagefenster showWindow:self];

	
	NSMutableDictionary* MatrixDic=[[NSMutableDictionary alloc]initWithCapacity:0];
	NSMutableArray* stateArray=[[NSMutableArray alloc]initWithCapacity:0];
	int i;
	for (i=0;i<100;i++)
	{
	[stateArray addObject:[NSNumber numberWithInt:[[[Tastenarray objectAtIndex:i]cell]state]]];
	
	}//for i
	[MatrixDic setObject:stateArray forKey:@"Tastenwerte"];
	[MatrixDic setObject:[Gruppefeld stringValue] forKey:@"Gruppe"];
	[MatrixDic setObject:[NSNumber numberWithInt:[Nummerfeld intValue]] forKey:@"Nummer"];
	[MatrixDic setObject:[NSNumber numberWithInt:[ModeSeg selectedSegment]] forKey:@"Mode"];
	[MatrixDic setObject:[ModeSeg labelForSegment:[ModeSeg selectedSegment]] forKey:@"Titel"];
	[MatrixDic setObject:[NSNumber numberWithInt:[Anzahlfeld intValue]] forKey:@"Anzahl"];

	NSNotificationCenter* nc=[NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"Tastenwerte" object:self userInfo:MatrixDic];
	[[PList objectForKey:@"gruppendic"]setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:[Gruppefeld stringValue]];

}

- (IBAction)clearTasten:(id)sender
{
int i,k;
for(i=0;i<10;i++)//Zeile
{
for (k=0;k<10;k++)//Kolonne
{
[[[Tastenarray objectAtIndex:i+10*k]cell]setState:0];

}
[[Wertarray objectAtIndex:i]setStringValue:@""];
}
[Ergebnisfeld setStringValue:@""];
//[Anzahlfeld setStringValue:@""];
}

-(IBAction)terminate:(id)sender
{
	BOOL OK=[self beenden];
	//NSLog(@"terminate");
	if (OK)
	{
		[NSApp terminate:self];
		
	}
	
}



- (BOOL)beenden
{
	//NSLog(@"last Gruppe: %@ last Nummer: %d",[Gruppefeld stringValue],[Nummerfeld intValue]);
	[[PList objectForKey:@"gruppendic"]setObject:[NSNumber numberWithInt:[Nummerfeld intValue]]forKey:[Gruppefeld stringValue]];
	
	BOOL BeendenOK=YES;
	NSString* PListPfad=[[[NSString stringWithString:NSHomeDirectory()]
								stringByAppendingPathComponent:@"Documents"]
								stringByAppendingPathComponent:@"TabData"];

	
	BOOL istOrdner=NO;	
	NSFileManager *Filemanager=[NSFileManager defaultManager];
	if ([Filemanager fileExistsAtPath:PListPfad isDirectory:&istOrdner]&& istOrdner)
	{
	//NSLog(@"PList-Ordner da");
	
	}
	else
	{
	//NSLog(@"PList-Ordner nicht da");

	BOOL OK=[Filemanager createDirectoryAtPath:PListPfad  attributes:NULL];
	}
	if (!PList) //noch keine PList
	{
		//NSLog(@"save PList: neue PList anlegen");
		PList=[[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
	}
			
	

	[PList setObject: [NSCalendarDate calendarDate] forKey:@"lastdate"];
	[PList setObject: [NSNumber numberWithInt:[ModeSeg selectedSegment]] forKey:@"lastmode"];
	[PList setObject: [NSNumber numberWithInt:[Nummerfeld intValue]] forKey:@"lastnummer"];
	[PList setObject: [Gruppefeld stringValue] forKey:@"lastgruppe"];
	//NSLog(@"save PList: %@",[PList description]);
	PListPfad=[PListPfad stringByAppendingPathComponent:@"TabPList"];
	BOOL PListOK=[PList writeToFile:PListPfad atomically:YES];

	
	
return BeendenOK;
}


- (BOOL)windowShouldClose:(id)sender
{
	BOOL OK=[self beenden];
	//NSLog(@"windowShouldClose");
	if (OK)
	{

		[NSApp terminate:self];
		
	}
	return OK;
}

@end
