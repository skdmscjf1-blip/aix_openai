from django.db import models

# Create your models here.
# BNO      NOT NULL NUMBER(10)     
# ID                VARCHAR2(100)  
# BTITLE            VARCHAR2(1000) 
# BCONTENT          CLOB           
# BGROUP            NUMBER(10)     
# BSTEP             NUMBER(10)     
# BINDENT           NUMBER(10)     
# BHIT              NUMBER(10)     
# BDATE             DATE           
# BFILE             VARCHAR2(100)  

class Board (models.Model):
    bno = models.AutoField(primary_key=True)
    id = models.CharField(max_length=100)
    nickname = models.CharField(max_length=100)
    btitle = models.CharField(max_length=1000)
    bcontent = models.TextField()
    bgroup = models.IntegerField(default=0)
    bstep = models.IntegerField(default=0)
    bindent = models.IntegerField(default=0)
    bhit = models.IntegerField(default=0)
    bdate = models.DateTimeField(auto_now=True,blank=True)

    def __str__(self):
        return f'{self.bno},{self.id},{self.nickname},{self.btitle}'