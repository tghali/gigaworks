/* Einstellungen */

#import <Cocoa/Cocoa.h>

#import "rVorlage.h"
#import "rArbeitsblatt.h"

@interface Knopf:NSButtonCell
{

}
- (id)initWithFrame:(NSRect)frame;


@end

@interface Einstellungen : NSPanel
{
    IBOutlet id Tasten;
	int	Mode;
	NSMatrix*		Tastenmatrix;
	
	NSView*			Tastenmatrixfeld;
	NSView*			Wertmatrixfeld;
	NSMatrix*		Wertmatrix;
	NSMutableArray* Tastenarray;
	NSMutableArray* Wertarray;
	NSTextField*	Anzahlfeld;
	NSImageCell*	Iconfeld;
	NSButton*		goArbeitsblattTaste;
	NSTextField*	Ergebnisfeld;
	NSTextField*	Nummerfeld;
	NSComboBox*		Gruppefeld;
	NSSegmentedControl* ModeSeg;
	rVorlage*		Vorlagefenster;
	rArbeitsblatt*	Arbeitsblattfenster;
	NSMutableDictionary* PList;
}

- (IBAction)setMode:(id)sender;
- (IBAction)setWert:(id)sender;
- (IBAction)showVorlage:(id)sender;
- (IBAction)clearTasten:(id)sender;
- (void)reCalc;
- (BOOL)beenden;
-(IBAction)terminate:(id)sender;

@end
