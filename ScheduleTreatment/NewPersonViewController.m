//
//  NewPersonViewController.m
//  ScheduleTreatment
//
//  Created by Edmar dos Reis Silva on 12/17/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import "NewPersonViewController.h"
#import <Parse/Parse.h>

@interface NewPersonViewController ()

@end

@implementation NewPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 *  Recolher teclados
 */
-(void)recolherTeclados
{
    // Recolher teclado
   [self.namePerson resignFirstResponder];
   [self.emailPerson resignFirstResponder];
   [self.phoneNumberPerson resignFirstResponder];
   
}

- (IBAction)salvarAction:(id)sender {
    [self recolherTeclados];
    [self saveItemParse];
    [self clearFields];
  
}
- (IBAction)ClearView:(id)sender {
    [self clearFields];
}

-(void)clearFields{
    [self.namePerson setText:nil];
    [self.emailPerson setText:nil];
    [self.phoneNumberPerson setText:nil];

}

-(void)saveItemParse{
    // Criando novo objeto
    PFObject *objeto = [PFObject objectWithClassName:@"Person"];
    
    // buscando o usuario local
    PFUser *usuarioLogado = [PFUser currentUser];
    
    if (usuarioLogado){
        
        // Preenchendo valores
        objeto[@"name"] = self.namePerson.text;
        objeto[@"email"] = self.emailPerson.text;
        objeto[@"phone_number"] = self.phoneNumberPerson.text;
        objeto[@"user"] = usuarioLogado;
        /*
         * Metodo para salvar o paciente
         * Segundo a documentacao do parse o saveEventually salva o cliente quando puder.
         * Ou seja caso o dispositivo estiver sem internet e houver tentativa de salvar o objeto
         * O mesmo vai ficar em estado de aguardando ate o dispositivo se conectar, dai os dados serao gravados remotamente
         * Mesmo o aplicativo indo para backgroud ou sendo finalizado. Ao retornar para ativo haverao tentativas
         */
        [objeto saveEventually];
    }
}

@end
