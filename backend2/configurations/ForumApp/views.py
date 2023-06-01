from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.shortcuts import redirect, render
from django.contrib import messages
def signup(request):

    if request.method == "POST":
     
        username = request.POST['username']
        try:       
            user_exist_or_not=User.objects.get(username=username)  
            messages.error(request,"user already exists")
            return redirect("some_error_page")
        
        except User.DoesNotExist:
            print("user does not exist")
       
 
        email = request.POST['email']
        pass1 = request.POST['password1']
        pass2 = request.POST['password2']

        myuser = User.objects.create(username=username, email=email, password=pass1 )

        messages.success(request, 'Your account has been succesfully created.')

        return redirect('/login')
        


    return render(request, "auth/register")