# SportStack's Development Report

Welcome to the documentation pages of **SportStack**!

You can find here detailed about the SportStack application, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling
  * [Product Vision](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/main/docs/ProductVision.md)
* Requirements
  * [User stories](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/edit/main/docs/requirements.md#user-stories)
  * [Domain model](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/edit/main/docs/requirements.md#domain-model)
* Architecture and Design
  * [Logical architecture](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/main/docs/ArchitectureAndDesign.md#logical-architecture)
  * [Physical architecture](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/main/docs/ArchitectureAndDesign.md#physical-architecture)
  * [Prototype (TODO)]()
* [Implementation (TODO)]()
* [Configuration and change management (TODO)]()
* [Project management (TODO)](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/main/docs/ProjectManagement.md)


## Product Vision

### Vision Statement

Tens aquele amigo que desmarca à última da hora e te deixa pendurado? Não te preocupes, com **SportStack** fazemos com que o jogo não seja adiado ou cancelado.
Lança convites na app para outras pessoas se juntarem nas mais diversas modalidades que temos à tua disposição.
Basta escolheres a modalidade, hora, local e diverte-te.



# User Stories

**Story#1**

As a user I want to be able to login to the app with my credentials. If I don't have the credentials and it is the first time using the app, I can create an account.

**User interface mock-up**


**Screen to login**

<img width="200" alt="Captura de ecrã 2023-03-16, às 15 51 34" src="https://user-images.githubusercontent.com/93987310/225676002-d8d4a6a1-0d2c-4cbf-a697-29ec9f334402.png">


**Button to create user**

<img width="158" alt="Captura de ecrã 2023-03-16, às 15 56 27" src="https://user-images.githubusercontent.com/93987310/225678213-a8015a4a-e5f7-4113-a190-cc429e4be20c.png">


**Screen to create user**

<img width="200" alt="Captura de ecrã 2023-03-16, às 15 53 16" src="https://user-images.githubusercontent.com/93987310/225676825-65438809-1681-4454-a891-455314fd7610.png">


**Story#2**

As a user I want to be able to create a new event and decide what kind of sport I can play, location, time, and teammates. If I don't want to create a new one, I can join one that already exists.

**User interface mock-up**


**HomeScreen**

<img width="200" alt="Captura de ecrã 2023-03-16, às 16 12 56" src="https://user-images.githubusercontent.com/93987310/225683759-e0978c1a-c997-4d73-9790-862a5d98c177.png">


**Button to create an event**

<img width="130" alt="Captura de ecrã 2023-03-16, às 16 15 07" src="https://user-images.githubusercontent.com/93987310/225683980-66ea860e-2ec1-43a4-a7e6-0db2f753210f.png">


**Screen to create the event**

<img width="200" alt="Captura de ecrã 2023-03-16, às 16 15 47" src="https://user-images.githubusercontent.com/93987310/225685375-e238fb11-7052-469e-b8a7-bb89e98e15dc.png">


**Story#3**

As a user I want to be able to see what are the best places to do my sport and vote if I like it or not.

**User interface mock-up**


**Screen to see all the places**

<img width="200" alt="Captura de ecrã 2023-03-16, às 16 24 16" src="https://user-images.githubusercontent.com/93987310/225686528-f759e707-946c-4075-accf-54e4d8511384.png">


**Story#4**

As a user I want to be able to create a team, look at my team-stats and the sports we usually do. By clicking on my profile picture I can directly access my profile where I can edit my date of birth, the sports I want to practice and my location. 

**User interface mock-up**


**Screen to create and see my teams**

<img width="200" alt="Captura de ecrã 2023-03-16, às 16 55 06" src="https://user-images.githubusercontent.com/93987310/225694766-085bc910-ede7-497a-80aa-beb846b08467.png">




**User Profile**

<img width="200" alt="Captura de ecrã 2023-03-16, às 16 53 41" src="https://user-images.githubusercontent.com/93987310/225694480-c893c8db-d43b-47e7-8148-8dbedea862ea.png">





### Domain model


 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2022-23/2LEIC03T5/blob/97bbba905bd0aaa1e48f22fefe504c88b13474e4/images/DomainModel.png"/>
</p>
