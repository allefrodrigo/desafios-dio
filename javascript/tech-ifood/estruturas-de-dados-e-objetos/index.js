class Heroi {
    constructor(nome, idade, tipo) {
      this.nome = nome;
      this.idade = idade;
      this.tipo = tipo;
    }
  
    atacar() {
      let ataque = '';
  
      switch (this.tipo.toLowerCase()) {
        case 'mago':
          ataque = 'usou magia';
          break;
        case 'guerreiro':
          ataque = 'usou espada';
          break;
        case 'monge':
          ataque = 'usou artes marciais';
          break;
        case 'ninja':
          ataque = 'usou shuriken';
          break;
        default:
          ataque = 'usou um ataque desconhecido';
      }
  
      console.log(`O ${this.tipo} atacou usando ${ataque}`);
    }
  }
  
  const heroi1 = new Heroi('Arthur', 30, 'Mago');
  heroi1.atacar();  
  
  const heroi2 = new Heroi('Leon', 25, 'Guerreiro');
  heroi2.atacar();  
  
  const heroi3 = new Heroi('Morgan', 28, 'Monge');
  heroi3.atacar();  
  
  const heroi4 = new Heroi('Sasuke', 18, 'Ninja');
  heroi4.atacar();  
  