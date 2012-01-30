/* rVorlage */

#import <Cocoa/Cocoa.h>



@interface rVorlagerahmen: NSView
{
	NSMutableArray* TastenwertArray;
	//NSMutableArray* Wertarray;
	int mode;
}
- (void)setMatrix:(NSArray*)Tastenwerte;
@end




@interface rVorlageDruckfeld: NSView
{
IBOutlet	NSTextField*			Gruppefeld;
IBOutlet	NSTextField*			Datumfeld;
IBOutlet	NSTextField*			Namefeld;
IBOutlet	NSTextField*			Nummerfeld;
IBOutlet	NSTextField*			Titelfeld;
//IBOutlet	rRahmen*				Titelrahmen;
IBOutlet	rVorlagerahmen*			Vorlagerahmen;

}

@end 


@interface rVorlage : NSWindowController
{
IBOutlet	id				VorlageFenster;
IBOutlet	rVorlageDruckfeld*				VorlageDruckfeld;

}
@end