//
//  Arbeitsblatt.h
//  Reihen
//
//  Created by Sysadmin on 25.03.08.
//  Copyright __MyCompanyName__ 2008 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
#define tabalpha 0.9

@interface rRahmen: NSView
{

}

@end

@interface rAufgabeRahmen: rRahmen
{
	NSMutableArray* TastenwertArray;
	//NSMutableArray* Wertarray;
	int mode;
}
- (void)setMatrix:(NSArray*)Tastenwerte;
@end


@interface rErgebnisRahmen: rRahmen
{
	NSMutableArray* TastenwertArray;
	NSMutableArray* Wertarray;
	int mode;
}
- (void)setMatrix:(NSArray*)Tastenwerte;
@end


@interface rDruckfeld: NSView
{
IBOutlet	NSTextField*			Gruppefeld;
IBOutlet	NSTextField*			Datumfeld;
IBOutlet	NSTextField*			Namefeld;
IBOutlet	NSTextField*			Nummerfeld;
IBOutlet	NSTextField*			Titelfeld;
IBOutlet	rRahmen*				Titelrahmen;
IBOutlet	rAufgabeRahmen*			Aufgaberahmen;
IBOutlet	NSTextField*			ErgebnisGruppefeld;
IBOutlet	NSTextField*			ErgebnisDatumfeld;
IBOutlet	NSTextField*			ErgebnisNamefeld;
IBOutlet	NSTextField*			ErgebnisNummerfeld;
IBOutlet	NSTextField*			ErgebnisTitelfeld;
IBOutlet	rRahmen*				ErgebnisTitelrahmen;
IBOutlet	rErgebnisRahmen*		Ergebnisrahmen;
NSRect Grupperahmen, Datumrahmen, Namerahmen, Nummerrahmen;
}

@end 



@interface rArbeitsblatt : NSWindowController
{
IBOutlet	rDruckfeld*				Druckfeld;
}
- (IBAction)printDocument:(id)sender;
- (void)BlattDruckenMitDicArray:(NSArray*)derProjektDicArray;
@end
