// src/app/app.routes.ts
import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { QuizzComponent } from './pages/quizz/quizz.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'quizz', component: QuizzComponent },
];
