//
//  AddDoctor.swift
//  list
//
//  Created by Rajit chaudhary on 29/05/24.
//
import SwiftUI
import UIKit

struct AddDoctorView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var gender: String = ""
    @State private var dob: String = ""
    @State private var licenseNumber: String = ""
    @State private var specialisation: String = ""
    @State private var qualification: String = ""
    @State private var experience: String = ""
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        isImagePickerPresented = true
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                    TextField("Phone number", text: $phoneNumber)
                }
                
                Section {
                    TextField("Gender", text: $gender)
                    TextField("DOB", text: $dob)
                }
                
                Section {
                    TextField("License number", text: $licenseNumber)
                }
                Section{
                    
                    TextField("Qualification", text: $qualification)
                }
                
                Section {
                    
                    TextField("Specialisation", text: $specialisation)
                    
                    TextField("Experience", text: $experience)
                }
            }
            .navigationBarTitle("Add a doctor", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $image)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct AddDoctorView_Previews: PreviewProvider {
    static var previews: some View {
        AddDoctorView()
    }
}
